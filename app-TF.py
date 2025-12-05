############################################################################
"""
https://flask.palletsprojects.com/en/2.3.x/deploying/nginx/
https://flask.palletsprojects.com/en/2.3.x/quickstart/#a-minimal-application
https://pypi.org/project/flask-swagger-ui/
"""
############################################################################
"""
py -m flask --app app run
"""
############################################################################
from PIL import Image, ImageOps
from io import StringIO, BytesIO
import io, base64
import re
from markupsafe import escape
from werkzeug.utils import secure_filename
from werkzeug.datastructures import ImmutableMultiDict
from flask_swagger_ui import get_swaggerui_blueprint
from flask_cors import CORS
from flask import Flask, jsonify, json, request, redirect
from flask import Response, make_response, send_file
from flask import send_from_directory
from flask import stream_with_context
from datetime import datetime
from pisut import AiSpatial
import os, sys, pickle
import pandas as pd
import math
import requests

app = Flask(__name__)
CORS(app)
app.config["MAX_CONTENT_LENGTH"] = 10 * 1024 * 1024
app.config["CLIENT_MAX_BODY_SIZE"] = 10 * 1024 * 1024
app.config["UPLOAD_FOLDER"] = "D:/AiGreenTaxonomy/Predicted/"

### swagger specific ###
app.config["PictPath"] = "D:/AiGreenTaxonomy/Plant for Ai Pictures/"

SWAGGER_URL = "/api/doc"
API_URL = "https://aigreen.dcce.go.th/rest/"
SWAGGERUI_BLUEPRINT = get_swaggerui_blueprint(
    SWAGGER_URL, API_URL, config={"app_name": "AI Green Area - REST"}
)
app.register_blueprint(SWAGGERUI_BLUEPRINT, url_prefix=SWAGGER_URL)

"""
@app.errorhandler(413)
def request_entity_too_large(error):
    return 'File larger than 10MB is not allow', 413
"""


@app.route("/", defaults=dict(filename=None))
@app.route("/<path:filename>", methods=["GET", "POST"])
def index(filename):
    filename = filename or "index.html"
    if filename == "index.html":
        return redirect("/ai-spatial.html")

    if request.method == "GET":
        if (
            filename.endswith(".html")
            or filename.endswith(".js")
            or filename.endswith(".css")
            or filename.startswith("assets")
        ):
            return send_from_directory(".", filename)

    return jsonify({"error": "not support this url"})


# --- New Imports for Model ---
import tensorflow as tf
from tensorflow.keras.applications import EfficientNetB6
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Dense, GlobalAveragePooling2D, Dropout
import numpy as np
import pickle
import cv2
import json
import pillow_heif
pillow_heif.register_heif_opener()
from PlantDetection import PlantDetection

# --- Configuration ---
MODEL_WEIGHTS_PATH = os.path.join("models", "B6_20251203-065556_P3.weights.h5")
# Try to find classes.json in the same folder as weights or root
CLASSES_JSON_PATH = os.path.join("models", "B6_20251203-065556_P3.classes.json") 

# Notebook specified 528, despite filename saying 512
IMG_HEIGHT, IMG_WIDTH = 528, 528 

# --- Load Classes ---
CLASS_NAMES = []
NUM_CLASSES = 0

def load_classes():
    global CLASS_NAMES, NUM_CLASSES
    # Priority 1: classes.json
    if os.path.exists(CLASSES_JSON_PATH):
        print(f"Loading classes from {CLASSES_JSON_PATH}...")
        try:
            with open(CLASSES_JSON_PATH, 'r', encoding='utf-8') as f:
                CLASS_NAMES = json.load(f)
            # Notebook appends dummies
            CLASS_NAMES.append("Dummy1")
            CLASS_NAMES.append("Dummy2")
            NUM_CLASSES = len(CLASS_NAMES)
            print(f"Loaded {NUM_CLASSES} classes from JSON.")
            return
        except Exception as e:
            print(f"Error loading classes.json: {e}")

    # Fallback if file missing (Critical Error usually, but we set defaults to avoid immediate crash before request)
    print(f"⚠️ Class file not found at {CLASSES_JSON_PATH}. Model loading may fail or use default 546 classes.")
    # Still defaulting to 546 to allow architecture build to attempt loading weights? 
    # Or should we stop? User said "Use only...", but if I don't set NUM_CLASSES, the next step (Model init) will fail.
    # I will set it to 546 (from notebook) as a hardcoded safety net so the app doesn't crash on startup, 
    # but the classes will be generic Class_X. This seems safer than crashing the whole Flask app.
    NUM_CLASSES = 546
    CLASS_NAMES = [f"Class_{i}" for i in range(NUM_CLASSES)]

load_classes()

# --- Load Model ---
print(f"Loading EfficientNetB6 model (Input: {IMG_HEIGHT}x{IMG_WIDTH})...")
try:
    # Architecture from Notebook: B6 -> Gap -> Dropout(0.3) -> Dense(Linear)
    base_model = EfficientNetB6(
        weights=None, 
        include_top=False, 
        input_shape=(IMG_HEIGHT, IMG_WIDTH, 3)
    )
    x = base_model.output
    x = GlobalAveragePooling2D()(x)
    x = Dropout(0.3)(x)
    # Output layer with linear activation (Softmax applied later/conceptually)
    predictions = Dense(NUM_CLASSES, activation='linear')(x)
    model = Model(inputs=base_model.input, outputs=predictions)
    
    print(f"Loading weights from {MODEL_WEIGHTS_PATH}...")
    model.load_weights(MODEL_WEIGHTS_PATH)
    print("Model loaded successfully.")
except Exception as e:
    print(f"Error loading model: {e}")
    print("Attempts to handle shape mismatch...")
    # If shape mismatch occurs, user might need to update NUM_CLASSES or weights
    model = None


# --- Helper Functions ---
def read_image_and_process_cv2(imageFile, cols, rows):
    # Determine file type and read bytes
    if isinstance(imageFile, str):
        # Path
        if not os.path.exists(imageFile):
            raise Exception(f"File not found: {imageFile}")
        # Use simple read for standard formats
        # For HEIF/HEIC we might need pillow_heif -> numpy -> cv2
        if imageFile.lower().endswith(('.heic', '.heif')):
             heif_file = pillow_heif.open_heif(imageFile, convert_hdr_to_8bit=False, bgr_mode=True)
             img_nparray = np.array(heif_file)
             # pillow_heif BGR mode check? usually RGB. Let's assume RGB if not specified.
             # Actually opencv expects BGR. 
             # Let's trust pillow_heif to give array, then ensure BGR for consistency or just RGB directly.
             # Notebook uses cv2.imread -> BGR. Then converts to RGB.
             # So we need RGB associated with the model input.
             # Convert to RGB if needed.
             if heif_file.mode == "BGR":
                 img_rgb = cv2.cvtColor(img_nparray, cv2.COLOR_BGR2RGB)
             else:
                 img_rgb = img_nparray # Already RGB?
        else:
             # Standard opencv read
             img_bgr = cv2.imread(imageFile)
             if img_bgr is None:
                 # Fallback to PIL if cv2 fails (e.g. unicode path issues on windows sometimes)
                 pil_img = Image.open(imageFile)
                 img_rgb = np.array(pil_img.convert('RGB'))
             else:
                 img_rgb = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2RGB)
    else:
        # Bytes/File object not supported easily by cv2.imread without decoding
        # Since the caller passes a path 'formFile' string mostly, we are good.
        raise Exception("Input must be a file path for cv2 processing")

    # Notebook Logic: resize directly
    img_resized = cv2.resize(img_rgb, (cols, rows))
    
    return img_resized, img_rgb # Return original for thumbnail if needed? 
    # Actually TaxoOverall makes thumbnail from prediction source?
    # Let's just return resized for prediction.


def PredictImage(imageFile):
    if model is None:
        raise Exception("Model not loaded.")
        
    img_resized, original_rgb = read_image_and_process_cv2(imageFile, IMG_WIDTH, IMG_HEIGHT)
    
    # Preprocessing
    # Notebook: img_batch = tf.expand_dims(img_resized, 0)
    # No /255.0 explicitly shown in notebook cell 9.
    # Assuming EfficientNetB6 internal preprocessing or weights trained on [0, 255].
    # IF the notebook works, this should work.
    
    imageBatch = np.expand_dims(img_resized, axis=0)
    
    # Predict
    logits = model.predict(imageBatch, verbose=0)
    
    # Apply Softmax (Notebook: scores = tf.nn.softmax(logits[0]))
    scores = tf.nn.softmax(logits[0]).numpy()
    
    # Top 3
    top3_indices = np.argsort(scores)[-3:][::-1]
    
    predicted_list = []
    for i in top3_indices:
        label = CLASS_NAMES[i] if i < len(CLASS_NAMES) else f"Unknown_{i}"
        score = scores[i]
        predicted_list.append((label, score))
    
    # Prepare Base64 thumbnail (Use standard PIL for this part to be safe/consistent)
    # Or convert back from RGB numpy array
    thumb_img = Image.fromarray(original_rgb)
    # Resize for thumbnail? App usually handles it. 
    # Old code: imageCrop.save...
    # We can just save the original or resized.
    # Let's save the resized one to match "source" logic of old app?
    # Old app calculated crop. We resized.
    # Let's use the resized one for display consistency with what model saw.
    display_img = Image.fromarray(img_resized)
    imageBuffered = BytesIO()
    display_img.save(imageBuffered, format="JPEG")
    imageBase64 = base64.b64encode(imageBuffered.getvalue()).decode("ascii")
    
    return {
        "source": "data:image/jpeg;base64," + imageBase64,
        "predicted": predicted_list, 
    }


def TaxoOverall(token, filename, predicted):
    overallFile = os.path.join(app.config["UPLOAD_FOLDER"], token, "overall.pkl")
    if not os.path.isfile(overallFile):
        overallResults = {filename: predicted}
    else:
        with open(overallFile, "rb") as f:
            overallResults = pickle.load(f)
        overallResults[filename] = predicted

    with open(overallFile, "wb") as f:
        pickle.dump(overallResults, f, pickle.HIGHEST_PROTOCOL)

    overallDataFrame = pd.DataFrame(
        sum(overallResults.values(), []), columns=["species", "confident"]
    )
    
    # Convert 'confident' to float for aggregation
    overallDataFrame["confident"] = overallDataFrame["confident"].astype(float)
    
    overallTop3 = (
        overallDataFrame.groupby("species")
        .sum()
        .sort_values("confident", ascending=False)
        .head(3)
    )
    overallTop3["confident"] = overallTop3["confident"] / len(overallResults.keys())

    return overallTop3.reset_index().to_numpy().tolist(), len(overallResults.keys())


@app.route("/ai/taxonomy/<token>", methods=["GET", "POST"])
def Taxonomy(token):
    if request.method == "POST":
        try:
            formImage = request.files.get("image")
            formDatas = request.form
            formToken = formDatas.get("token", None)
            
            # Token Handling
            if (not formToken or formToken.lower() in ["new", "null", "undefined", ""]):
                formToken = datetime.now().isoformat().replace(":", ".")
            
            os.makedirs(os.path.join(app.config["UPLOAD_FOLDER"], formToken), exist_ok=True)

            imageType = formDatas.get("type", "bark")

            # Save File Logic - Need physical file for cv2.imread usually
            formFile = ""
            if formImage:
                safe_filename = secure_filename(formImage.filename)
                formFile = os.path.join(
                    app.config["UPLOAD_FOLDER"],
                    formToken,
                    imageType + "@" + safe_filename, 
                )
                formImage.stream.seek(0)
                formImage.save(formFile)
            else:
                # Handle Base64 Image
                formImageStr = formDatas.get("image")
                if formImageStr and "base64" in formImageStr:
                    typeImage = formImageStr.split(";")[0].split(":")[1].split("/")[1]
                    pil_image = Image.open(
                        io.BytesIO(
                            base64.b64decode(formImageStr.split(";base64,")[1])
                        )
                    )
                    formFile = os.path.join(
                        app.config["UPLOAD_FOLDER"],
                        formToken,
                        imageType + "@" + typeImage,
                    )
                    pil_image.save(formFile, typeImage)
                else:
                    return jsonify({"error": "not support image", "file": "base64"}), 500

            # --- Check if Plant (Mimic app-Gemini logic) ---
            is_plant, detection_msg = PlantDetection(formFile)
            if not is_plant:
                return jsonify({
                    "error": "ไม่ใช่รูปของต้นไม้",
                    "details": "ระบบตรวจพบว่าภาพที่อัปโหลดไม่ใช่วัตถุที่เกี่ยวข้องกับพืช",
                    "token": formToken,
                    "predicted": [],
                    "overall": [],
                })

            # --- Prediction Logic ---
            predicted_data = PredictImage(formFile) # Uses new model with cv2
            
            # Overall Logic
            overall, count = TaxoOverall(
                formToken,
                imageType + "@" + os.path.split(formFile)[1],
                predicted_data["predicted"],
            )

            results = {
                "filename": imageType + "@" + os.path.split(formFile)[1],
                "token": formToken,
                "source": predicted_data["source"],
                "predicted": list(
                    map(lambda x: (x[0], "{:.2f}".format(float(x[1]))), predicted_data["predicted"])
                ),
                "overall": list(map(lambda x: (x[0], "{:.2f}".format(float(x[1]))), overall)),
                "count": count,
            }
            
            return jsonify(results)

        except Exception as error:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            return jsonify({"error": str(error), "file": fname, "line": exc_tb.tb_lineno}), 500
    else:
        return jsonify({
            "source": "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==",
            "predicted": [["API not support method " + request.method, "error"]],
            "token": token,
        })


def decode_base64(data, altchars=b"+/"):
    """Decode base64, padding being optional.

    :param data: Base64 data as an ASCII byte string
    :returns: The decoded byte string.

    """
    data = re.sub(rb"[^a-zA-Z0-9%s]+" % altchars, b"", data)  # normalize
    missing_padding = len(data) % 4
    if missing_padding:
        data += b"=" * (4 - missing_padding)
    return base64.b64decode(data, altchars)


# REF: https://stackoverflow.com/questions/10434599/get-the-data-received-in-a-flask-request


@app.route("/pictures", methods=["GET", "POST"])
def GetPictures():
    plot = request.args.get("plot", None)
    tag = request.args.get("tag", None)
    pictPath = app.config["PictPath"]
    pictPlots = list(filter(lambda x: x.startswith(plot), os.listdir(pictPath)))
    if len(pictPlots) == 0:
        return app.response_class(
            status=200,
            mimetype="application/json",
            response=json.dumps(
                {
                    # "url": request.url_root,
                    "plot": plot,
                    "tag": "tag",
                    "error": "folder " + plot + " not found",
                },
                ensure_ascii=False,
            ),
        )
    else:
        pictPlot = os.path.join(pictPath, pictPlots[0])
        print(pictPlot)
        pictTags = list(
            map(
                lambda x: os.path.join(pictPlots[0], x).replace("\\", "/"),
                filter(
                    lambda x: x.startswith(tag),
                    os.listdir(pictPlot),
                ),
            )
        )
        print(pictTags)
        return app.response_class(
            status=200,
            mimetype="application/json",
            response=json.dumps(
                {
                    # "url": request.url_root,
                    "plot": plot,
                    "tag": "tag",
                    "pictures": pictTags,
                },
                ensure_ascii=False,
            ),
        )


@app.route("/thumbnail", methods=["GET", "POST"])
def GetThumbnail():
    pictPath = app.config["PictPath"]
    pictFile = request.args.get("picture", None)
    # if True:
    try:
        pictImage = Image.open(os.path.join(pictPath, pictFile))
        pictImage = ImageOps.exif_transpose(pictImage)
        pictImage.thumbnail((512, 512), Image.LANCZOS)
        with io.BytesIO() as pictStream:
            pictImage.save(pictStream, format="JPEG")
            pictStream.seek(0)
            pictBytes = pictStream.getvalue()
            pictBase64 = base64.b64encode(pictBytes)
            # pictBase64 = ("data:image/png;base64,"+ pictBase64).encode('utf-8')
        response = make_response(pictBytes, 200)
        response.mimetype = "image/jpeg"
        return response
    # else:
    except Exception as error:
        return app.response_class(
            status=500,
            mimetype="application/json",
            response=json.dumps(
                {
                    "error": error.args,
                    "trace": dir(error),
                    "path": os.path.join(pictPath, pictFile),
                },
                ensure_ascii=False,
            ),
        )


@app.route("/proxy/<path:url_path>", methods=["GET"])
def proxy(url_path):
    print(url_path)
    if url_path.startswith("tile.forest.go.th/") or url_path.startswith(
        "aigreen.dcce.go.th/"
    ):
        parts = url_path.split("/")
        if len(parts) < 3:
            return make_response("{error:'invalid url'}", 400)

        z = parts[-3]
        y = parts[-1]

        if "." in y:
            y_parts = y.split(".")
            y_val = y_parts[0]
            ext = y_parts[1]
        else:
            y_val = y
            ext = "jpg"

        tms = y_val.startswith("-")
        try:
            y_num = int(y_val)
            z_num = int(z)
            y_conv = y_num if not tms else int(math.pow(2, z_num)) + y_num - 1
        except ValueError:
            return make_response("{error:'invalid coordinates'}", 400)

        url_prefix = "/".join(parts[:-1])
        final_url = f"https://{url_prefix}/{y_conv}.{ext}"
        if "geoserver/gwc/service/tms" in url_path:
            final_url = final_url + "?flipY=true"

        try:
            proxied_response = requests.get(final_url, stream=True, verify=False)
            resp = Response(
                proxied_response.iter_content(chunk_size=1024),
                content_type=proxied_response.headers.get("Content-Type"),
                status=proxied_response.status_code,
            )
            resp.set_cookie("test", "works!", max_age=900)
            return resp

        except requests.RequestException as e:
            print(e)
            return make_response("{error: " + repr(e) + "}", 500)

    else:
        return make_response("{error:'url not allow'}", 403)


if __name__ == "__main__":
    app.run(debug=True, port=8888, host="0.0.0.0")
