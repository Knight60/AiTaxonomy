import os
import tensorflow as tf
from tensorflow.keras.applications import EfficientNetB6
from tensorflow.keras.models import load_model

WEIGHTS_PATH = 'models/B6_20251203-065556_P3.weights.h5'

def inspect():
    print(f"Inspecting {WEIGHTS_PATH}...")
    
    # Attempt 1: Load as full model
    try:
        print("Attempting to load as full model...")
        model = load_model(WEIGHTS_PATH)
        print("Success! It is a full model.")
        print(f"Output shape: {model.output_shape}")
        return
    except Exception as e:
        print(f"Not a full model: {e}")

    # Attempt 2: Load weights into generic B6 (to find class count via error)
    print("\nAttempting to load weights into generic EfficientNetB6 (ImageNet)...")
    try:
        model = EfficientNetB6(weights=None, include_top=True) # Default 1000 classes
        model.load_weights(WEIGHTS_PATH)
        print("Loaded successfully into 1000-class model.")
    except Exception as e:
        print(f"Error loading weights: {e}")
        # Error usually looks like: ... shape (1000,) variable ... but got shape (120,) ...
        
if __name__ == "__main__":
    inspect()
