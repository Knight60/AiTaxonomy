############################################################################
# app.py (Fixed: Return FULL Base64 string for image source)
############################################################################
from PIL import Image, ImageOps
from io import StringIO, BytesIO
import io, base64
import re
import os, sys, json
import pandas as pd
import math
import requests
from datetime import datetime

# --- Flask & Utils Imports ---
from flask import (
    Flask,
    jsonify,
    request,
    redirect,
    Response,
    make_response,
    send_from_directory,
)
from flask_cors import CORS
from flask_swagger_ui import get_swaggerui_blueprint
from werkzeug.utils import secure_filename

# --- Vertex AI Imports ---
import vertexai
from vertexai.generative_models import GenerativeModel, Part, SafetySetting

app = Flask(__name__)
CORS(app)

# --- 1. Configuration ---
app.config["MAX_CONTENT_LENGTH"] = 50 * 1024 * 1024
app.config["UPLOAD_FOLDER"] = "D:/AiGreenTaxonomy/Predicted/"
app.config["PictPath"] = "D:/AiGreenTaxonomy/Plant for Ai Pictures/"

# Vertex AI Config
PROJECT_ID = "dcce-carbon"
LOCATION = "us-central1"

#https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models
MODEL_NAME = "gemini-2.5-flash" 
KEY_FILE_PATH = "dcce-carbon-credential.json"

# Set Credential
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = KEY_FILE_PATH
vertexai.init(project=PROJECT_ID, location=LOCATION)

# --- Swagger Config ---
SWAGGER_URL = "/api/doc"
API_URL = "https://aigreen.dcce.go.th/rest/"
SWAGGERUI_BLUEPRINT = get_swaggerui_blueprint(
    SWAGGER_URL, API_URL, config={"app_name": "AI Green Area - REST"}
)
app.register_blueprint(SWAGGERUI_BLUEPRINT, url_prefix=SWAGGER_URL)


# --- 2. Species Data (Cleaned Common Names) ---
supported_species = [
    {"common": "แสมขาว", "scientific": "Avicennia alba Blume"},
    {
        "common": "อโศกอินเดีย",
        "scientific": "Monoon longifolium (Sonn.) B.Xue & R.M.K.Saunders",
    },
    {
        "common": "ลำดวน",
        "scientific": "Sphaerocoryne lefevrei (Baill.) D.M.Johnson & N.A.Murray",
    },
    {"common": "สัตตบรรณ", "scientific": "Alstonia scholaris (L.) R.Br."},
    {"common": "ตีนเป็ดทะเล", "scientific": "Cerbera odollam Gaertn."},
    {"common": "โมกมัน", "scientific": "Wrightia arborea (Dennst.) Mabb."},
    {"common": "แคนา", "scientific": "Dolichandrone serrulata (Wall. ex DC.) Seem."},
    {"common": "ปีบ", "scientific": "Millingtonia hortensis L.f."},
    {"common": "ชมพูพันธุ์ทิพย์", "scientific": "Tabebuia rosea (Bertol.) DC."},
    {"common": "กระทิง", "scientific": "Calophyllum inophyllum L."},
    {"common": "สารภี", "scientific": "Mammea siamensis (Miq.) T.Anderson"},
    {"common": "สนทะเล", "scientific": "Casuarina equisetifolia L."},
    {"common": "สมอพิเภก", "scientific": "Terminalia bellirica (Gaertn.) Roxb."},
    {"common": "หูกวาง", "scientific": "Terminalia catappa L."},
    {"common": "หูกระจง", "scientific": "Terminalia ivorensis A.Chev."},
    {
        "common": "พะยอม",
        "scientific": "Anthoshorea roxburghii (G.Don) P.S.Ashton & J.Heck.",
    },
    {"common": "ยางนา", "scientific": "Dipterocarpus alatus Roxb. ex G.Don"},
    {"common": "ตะเคียนทอง", "scientific": "Hopea odorata Roxb."},
    {"common": "รัง", "scientific": "Pentacme siamensis (Miq.) Kurz"},
    {"common": "เต็ง", "scientific": "Shorea obtusa Wall. ex Blume"},
    {
        "common": "ยางพารา",
        "scientific": "Hevea brasiliensis (Willd. ex A.Juss.) Müll.Arg.",
    },
    {"common": "กระถินณรงค์", "scientific": "Acacia auriculiformis A.Cunn. ex Benth."},
    {"common": "กระถินเทพา", "scientific": "Acacia mangium Willd."},
    {"common": "มะค่าโมง", "scientific": "Afzelia xylocarpa (Kurz) Craib"},
    {"common": "พฤกษ์", "scientific": "Albizia lebbeck (L.) Benth."},
    {"common": "ทองกวาว", "scientific": "Butea monosperma (Lam.) Kuntze"},
    {"common": "กัลปพฤกษ์", "scientific": "Cassia bakeriana Craib"},
    {"common": "คูน", "scientific": "Cassia fistula L."},
    {"common": "พะยูง", "scientific": "Dalbergia cochinchinensis Pierre"},
    {"common": "ฉนวน", "scientific": "Dalbergia nigrescens Kurz"},
    {"common": "หางนกยูงฝรั่ง", "scientific": "Delonix regia (Bojer ex Hook.) Raf."},
    {"common": "เขลง", "scientific": "Dialium cochinchinense Pierre"},
    {"common": "อะราง", "scientific": "Peltophorum dasyrhachis (Miq.) Kurz"},
    {"common": "นนทรี", "scientific": "Peltophorum pterocarpum (DC.) Backer ex K.Heyne"},
    {"common": "ประดู่บ้าน", "scientific": "Pterocarpus indicus Willd."},
    {"common": "ประดู่ป่า", "scientific": "Pterocarpus macrocarpus Kurz"},
    {"common": "จามจุรี", "scientific": "Samanea saman (Jacq.) Merr."},
    {"common": "ขี้เหล็ก", "scientific": "Senna siamea (Lam.) H.S.Irwin & Barneby"},
    {"common": "มะค่าแต้", "scientific": "Sindora siamensis Teijsm. ex Miq."},
    {"common": "มะขาม", "scientific": "Tamarindus indica L."},
    {
        "common": "แดง",
        "scientific": "Xylia xylocarpa var. kerrii (Craib & Hutch.) I.C.Nielsen",
    },
    {"common": "สัก", "scientific": "Tectona grandis L.f."},
    {"common": "จิกน้ำ", "scientific": "Barringtonia acutangula (L.) Gaertn."},
    {"common": "กระโดน", "scientific": "Careya arborea Roxb."},
    {"common": "ตะแบกนา", "scientific": "Lagerstroemia floribunda Jack"},
    {"common": "อินทรชิต", "scientific": "Lagerstroemia loudonii Teijsm. & Binn."},
    {"common": "อินทนิลน้ำ", "scientific": "Lagerstroemia speciosa (L.) Pers."},
    {"common": "จำปี", "scientific": "Magnolia × alba (DC.) Figlar"},
    {"common": "สะเดา", "scientific": "Azadirachta indica A.Juss."},
    {"common": "มะฮอกกานีใบใหญ่", "scientific": "Swietenia macrophylla King"},
    {"common": "ขนุน", "scientific": "Artocarpus heterophyllus Lam."},
    {"common": "ไทรย้อยใบแหลม", "scientific": "Ficus benjamina L."},
    {"common": "โพศรีมหาโพ", "scientific": "Ficus religiosa L."},
    {"common": "โพขี้นก", "scientific": "Ficus rumphii Blume"},
    {"common": "ข่อย", "scientific": "Streblus asper Lour."},
    {"common": "หว้า", "scientific": "Syzygium cumini (L.) Skeels"},
    {"common": "โกงกางใบเล็ก", "scientific": "Rhizophora apiculata Blume"},
    {"common": "โกงกางใบใหญ่", "scientific": "Rhizophora mucronata Poir."},
    {"common": "คำมอกหลวง", "scientific": "Gardenia sootepensis Hutch."},
    {"common": "พิกุล", "scientific": "Mimusops elengi L."},
]

# Map for quick lookup
SPECIES_MAP = {s["scientific"]: s["common"] for s in supported_species}

# --- Helper Functions ---


def get_species_prompt():
    list_text = "\n".join([f"- {s['scientific']}" for s in supported_species])
    return f"""
    Role: Expert Botanist.
    Task: Identify the plant in the image.

    Rules:
    1. If the image is NOT a plant/tree/leaf/bark (e.g., car, person, building, blank), return exactly: [["NOT_A_PLANT", 1.0]]
    2. If it IS a plant, identify it from this list ONLY:
    {list_text}
    
    3. Output format: Strict JSON Array only. NO Markdown. NO code blocks.
    Example: [["Tectona grandis L.f.", 0.95], ["Xylia xylocarpa", 0.05]]
    """


def clean_and_parse_json(text):
    clean_text = text.replace("```json", "").replace("```", "").strip()
    first_bracket = clean_text.find("[")
    last_bracket = clean_text.rfind("]")
    if first_bracket != -1 and last_bracket != -1:
        clean_text = clean_text[first_bracket : last_bracket + 1]
    try:
        return json.loads(clean_text)
    except Exception as e:
        print(f"Raw text from Gemini: {text}")
        raise Exception(f"Failed to parse JSON: {str(e)}")


def calculate_overall(token_path, filename, current_predicted):
    overall_file = os.path.join(token_path, "overall.json")
    overall_results = {}
    if os.path.isfile(overall_file):
        try:
            with open(overall_file, "r", encoding="utf8") as f:
                overall_results = json.load(f)
        except:
            overall_results = {}

    overall_results[filename] = current_predicted
    with open(overall_file, "w", encoding="utf8") as f:
        json.dump(overall_results, f, indent=2, ensure_ascii=False)

    all_predictions = []
    for preds in overall_results.values():
        for p in preds:
            all_predictions.append(p)

    species_stats = {}
    total_images = len(overall_results.keys())
    for species, score in all_predictions:
        if species != "NOT_A_PLANT":
            score_float = float(score)
            if species not in species_stats:
                species_stats[species] = 0
            species_stats[species] += score_float

    averaged_results = []
    for species, total_score in species_stats.items():
        averaged_results.append([species, total_score / total_images])

    averaged_results.sort(key=lambda x: x[1], reverse=True)
    return averaged_results[:3], total_images


def process_and_resize_image(image_bytes, max_size=1080):
    try:
        img = Image.open(io.BytesIO(image_bytes))
        img = ImageOps.exif_transpose(img)
        width, height = img.size
        if max(width, height) > max_size:
            img.thumbnail((max_size, max_size), Image.LANCZOS)
            print(f"Resized image from {width}x{height} to {img.size}")
        output_buffer = io.BytesIO()
        fmt = img.format if img.format else "JPEG"
        if fmt.upper() not in ["JPEG", "JPG", "PNG", "WEBP"]:
            fmt = "JPEG"
        if fmt.upper() == "JPEG" and img.mode in ("RGBA", "LA"):
            background = Image.new(img.mode[:-1], img.size, "#ffffff")
            background.paste(img, img.split()[-1])
            img = background
        img.save(output_buffer, format=fmt, quality=90)
        return output_buffer.getvalue(), fmt.lower()
    except Exception as e:
        print(f"Error resizing image: {e}")
        return image_bytes, "jpeg"


# --- Route ---
@app.route("/ai/taxonomy/<token>", methods=["POST"])
def Taxonomy(token):
    try:
        form_token = token
        if not form_token or form_token.lower() in ["new", "null", "undefined", ""]:
            form_token = datetime.now().isoformat().replace(":", ".")

        token_path = os.path.join(app.config["UPLOAD_FOLDER"], form_token)
        os.makedirs(token_path, exist_ok=True)

        image_type = request.form.get("type", "bark")
        form_file_path = ""
        mime_type = "image/jpeg"
        raw_image_data = None
        filename_ext = "jpg"

        if "image" in request.files:
            file = request.files["image"]
            original_filename = secure_filename(file.filename)
            raw_image_data = file.read()
            if original_filename.lower().endswith(".png"):
                filename_ext = "png"
            elif original_filename.lower().endswith(".webp"):
                filename_ext = "webp"

        elif request.form.get("image"):
            b64_data = request.form.get("image")
            pattern = r"^data:([a-zA-Z0-9-+./]+);base64,(.+)$"
            match = re.match(pattern, b64_data)
            if match:
                mime_type = match.group(1)
                b64_str = match.group(2)
                raw_image_data = base64.b64decode(b64_str)
                filename_ext = mime_type.split("/")[1]
            else:
                return jsonify({"error": "Invalid base64 format"}), 400

        if not raw_image_data:
            return jsonify({"error": "No image content received"}), 400

        processed_image_data, final_fmt = process_and_resize_image(
            raw_image_data, max_size=1080
        )
        if final_fmt == "png":
            mime_type = "image/png"
        elif final_fmt == "webp":
            mime_type = "image/webp"
        else:
            mime_type = "image/jpeg"
            filename_ext = "jpg"

        save_name = f"{image_type}@{datetime.now().strftime('%H%M%S')}.{filename_ext}"
        form_file_path = os.path.join(token_path, save_name)
        with open(form_file_path, "wb") as f:
            f.write(processed_image_data)

        model = GenerativeModel(MODEL_NAME)
        image_part = Part.from_data(data=processed_image_data, mime_type=mime_type)

        responses = model.generate_content(
            [get_species_prompt(), image_part],
            generation_config={"response_mime_type": "application/json"},
        )

        predicted_data = clean_and_parse_json(responses.text)

        if len(predicted_data) > 0 and predicted_data[0][0] == "NOT_A_PLANT":
            return jsonify(
                {
                    "error": "ไม่ใช่รูปของต้นไม้",
                    "details": "ระบบตรวจพบว่าภาพที่อัปโหลดไม่ใช่วัตถุที่เกี่ยวข้องกับพืช",
                    "token": form_token,
                    "predicted": [],
                    "overall": [],
                }
            )

        relative_filename = os.path.basename(form_file_path)
        overall, count = calculate_overall(
            token_path, relative_filename, predicted_data
        )

        def format_results(lst):
            formatted = []
            for item in lst:
                scientific = item[0]
                score = "{:.2f}".format(float(item[1]))
                thai_name = SPECIES_MAP.get(scientific, "")
                formatted.append([score, scientific, thai_name])
            return formatted

        # ❗️ แก้ไขตรงนี้: ส่ง Base64 เต็มๆ ไม่ตัดทอน เพื่อให้ Frontend แสดงรูปได้
        source_preview = f"data:{mime_type};base64,{base64.b64encode(processed_image_data).decode('utf-8')}"

        return jsonify(
            {
                "filename": relative_filename,
                "token": form_token,
                "source": source_preview,
                "predicted": format_results(predicted_data),
                "overall": format_results(overall),
                "count": count,
            }
        )

    except Exception as error:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        return (
            jsonify({"error": str(error), "file": "app.py", "line": exc_tb.tb_lineno}),
            500,
        )


# --- Existing Routes ---
@app.route("/", defaults=dict(filename=None))
@app.route("/<path:filename>", methods=["GET", "POST"])
def index(filename):
    filename = filename or "index.html"
    if filename == "index.html":
        return redirect("/ai-spatial.html")
    if request.method == "GET":
        if filename.endswith((".html", ".js", ".css")) or filename.startswith("assets"):
            return send_from_directory(".", filename)
    return jsonify({"error": "not support this url"})


@app.route("/pictures", methods=["GET", "POST"])
def GetPictures():
    plot = request.args.get("plot", None)
    tag = request.args.get("tag", None)
    pictPath = app.config["PictPath"]
    try:
        pictPlots = list(filter(lambda x: x.startswith(plot), os.listdir(pictPath)))
        if len(pictPlots) == 0:
            return jsonify({"error": "folder not found"})
        pictPlot = os.path.join(pictPath, pictPlots[0])
        pictTags = list(
            map(
                lambda x: os.path.join(pictPlots[0], x).replace("\\", "/"),
                filter(lambda x: x.startswith(tag), os.listdir(pictPlot)),
            )
        )
        return jsonify({"plot": plot, "tag": "tag", "pictures": pictTags})
    except Exception as e:
        return jsonify({"error": str(e)})


@app.route("/thumbnail", methods=["GET", "POST"])
def GetThumbnail():
    pictPath, pictFile = app.config["PictPath"], request.args.get("picture", None)
    try:
        img = Image.open(os.path.join(pictPath, pictFile))
        img = ImageOps.exif_transpose(img)
        img.thumbnail((512, 512), Image.LANCZOS)
        buf = io.BytesIO()
        img.save(buf, "JPEG")
        buf.seek(0)
        return make_response(buf.getvalue(), 200, {"Content-Type": "image/jpeg"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/proxy/<path:url_path>", methods=["GET"])
def proxy(url_path):
    if not (
        url_path.startswith("tile.forest.go.th/")
        or url_path.startswith("aigreen.dcce.go.th/")
    ):
        return make_response("{error:'url not allow'}", 403)
    parts = url_path.split("/")
    z = parts[-3]
    y = parts[-1]
    if "." in y:
        y_val, ext = y.split(".")
    else:
        y_val, ext = y, "jpg"
    tms = y_val.startswith("-")
    try:
        y_num = int(y_val)
        z_num = int(z)
        y_conv = y_num if not tms else int(math.pow(2, z_num)) + y_num - 1
    except:
        return make_response("", 400)
    url_prefix = "/".join(parts[:-1])
    final_url = f"https://{url_prefix}/{y_conv}.{ext}"
    if "geoserver/gwc/service/tms" in url_path:
        final_url += "?flipY=true"
    try:
        r = requests.get(final_url, stream=True, verify=False)
        return Response(
            r.iter_content(1024),
            content_type=r.headers.get("Content-Type"),
            status=r.status_code,
        )
    except Exception as e:
        return make_response(str(e), 500)


if __name__ == "__main__":
    app.run(debug=True, port=8888, host="0.0.0.0")
