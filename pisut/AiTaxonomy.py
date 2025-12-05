from joblib import load as jobLoad
from joblib import dump as jobDump
from joblib import Parallel, delayed
import math
import random
import itertools
from functools import reduce
import pandas as pd
import os
import sys
import pickle
from contextlib import suppress
from datetime import datetime
import base64
from io import BytesIO

import cv2
import numpy as np
from keras import layers
from keras.layers import (
    Input,
    Add,
    Dense,
    Activation,
    ZeroPadding2D,
    BatchNormalization,
    Flatten,
    Conv2D,
    AveragePooling2D,
    MaxPooling2D,
)
from keras.models import Model, load_model
from keras.initializers import glorot_uniform
from keras.utils import plot_model
from IPython.display import SVG

# from keras.utils.vis_utils import model_to_dot
from tensorflow.keras.utils import plot_model

import keras.backend as K
import tensorflow as tf
from tensorflow.python.framework import ops

import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from PIL import Image, ImageOps
import pillow_heif as heif

heif.register_heif_opener()

# from sklearn.model_selection import train_image_split

# sys.modules['sklearn.externals.joblib'] = joblib
# from sklearn.externals.joblib import Parallel, delayed

os.environ["CUDA_VISIBLE_DEVICES"] = "0"
# print(tf.config.list_physical_devices('GPU'))


def ImageCropAtCenter(img, w, h, new_w=None, new_h=None, portrait=False):
    width, height = img.size  # Get dimensions
    if portrait and width > height:
        img = img.rotate(90, expand=True)
    width, height = img.size  # Get dimensions

    left = (width - w) / 2
    top = (height - h) / 2
    right = (width + w) / 2
    bottom = (height + h) / 2
    new_img = img.crop((left, top, right, bottom))
    if new_w and new_h:
        new_img = new_img.resize((new_w, new_h))
    return new_img


def ImageResizeAt(img, w, h, portrait=False):
    width, height = img.size  # Get dimensions
    if portrait and width > height:
        img = img.rotate(90, expand=True)
        width, height = img.size  # Get dimensions

    if height * (h / w) > width:
        new_width = width
        new_height = int(width * (h / w))
    else:
        new_height = height
        new_width = int(height * (w / h))
    return ImageCropAtCenter(img, new_width, new_height, w, h)


def read_image(imageFile, cols, rows):
    if heif.is_supported(imageFile):
        print("open heif")
        heif_file = heif.open_heif(imageFile, convert_hdr_to_8bit=False, bgr_mode=False)
        image = Image.fromarray(np.array(heif_file))
        del heif_file
    else:  # Read HEIF not work with joblib
        print("open jpg")
        with Image.open(imageFile) as img:
            image = ImageOps.exif_transpose(img).copy()
    return ImageResizeAt(image, cols, rows)


thisFile = os.path.abspath(__file__)
thisPath = os.path.dirname(thisFile)
classesPKL = os.path.join(thisPath, "Classes-60Cls-256x256-80%10%10%-All.pkl")
modelFile = os.path.join(
    thisPath, "D:\\AiGreenTaxonomy\\TrainSet-60Cls-256x256-80%10%10%-All.Epoc30.keras"
)
modelKeras = load_model(modelFile)
# **************************************************
COLS = 256
ROWS = COLS  # int(COLS*(4/3))
CHANNELS = 3
# **************************************************
with open(classesPKL, "rb") as f:
    classesData = pickle.load(f)
classesKeys = classesData["classes_keys"]
classesIds = classesData["classes_ids"]


def Predicted(imageFile):
    imageCrop = read_image(imageFile, COLS, ROWS)
    imageArray = np.array(imageCrop) / 255.0
    np.set_printoptions(formatter={"float": "{: 0.3f}".format})
    imagePredicted = modelKeras.predict(np.array([imageArray]))[0]
    imagePredicted = dict(zip(classesIds.keys(), imagePredicted))
    imageSortedPred = sorted(imagePredicted.items(), key=lambda x: x[1], reverse=True)
    imageBuffered = BytesIO()
    imageCrop.save(imageBuffered, format="JPEG")
    imageBase64 = base64.b64encode(imageBuffered.getvalue()).decode("ascii")
    # print(imageBuffered.getvalue()) #Btyes
    return {
        "source": "data:image/jpeg;base64," + imageBase64,
        "predicted": [imageSortedPred[0], imageSortedPred[1], imageSortedPred[2]],
    }
