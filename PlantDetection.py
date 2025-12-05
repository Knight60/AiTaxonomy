import os
import numpy as np
from tensorflow.keras.applications.resnet50 import ResNet50, preprocess_input, decode_predictions
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image

# --- Configuration ---
MODEL_FILENAME = 'models/resnet50_imagenet.h5'

# --- 1. Model Loading Logic (Auto Save/Load) ---
print("Checking model status...")
if os.path.exists(MODEL_FILENAME):
    print(f"Found local model: {MODEL_FILENAME}. Loading...")
    # compile=False ช่วยให้โหลดเร็วขึ้นเพราะเราใช้แค่ Predict ไม่ได้ Train ต่อ
    model = load_model(MODEL_FILENAME, compile=False) 
else:
    print(f"Model file not found. Downloading ResNet50 (ImageNet)...")
    model = ResNet50(weights='imagenet')
    print(f"Saving model to {MODEL_FILENAME} for future use...")
    model.save(MODEL_FILENAME)

print("Model is ready.")

# --- 2. Global Plant Keywords ---
PLANT_KEYWORDS = [
    # General
    'tree', 'flower', 'leaf', 'leaves', 'grass', 'plant', 'vegetation',
    'shrub', 'bush', 'forest', 'orchard', 'garden', 'greenhouse', 'pot',
    # Fruits
    'fruit', 'apple', 'banana', 'orange', 'lemon', 'lime', 'pineapple',
    'pomegranate', 'fig', 'jackfruit', 'custard_apple', 'strawberry', 
    'raspberry', 'blueberry', 'blackberry', 'grape', 'cherry', 'peach', 
    'pear', 'plum', 'apricot', 'coconut', 'durian', 'mango', 'papaya',
    'persimmon', 'star_fruit', 'lychee', 'longan', 'rambutan', 'guava',
    'granny_smith', 'delicious', 
    # Vegetables & Roots
    'vegetable', 'broccoli', 'cabbage', 'cauliflower', 'zucchini', 
    'squash', 'pumpkin', 'cucumber', 'artichoke', 'pepper', 'chili', 
    'bell_pepper', 'corn', 'maize', 'ear', 'potato', 'tomato', 'carrot', 
    'radish', 'turnip', 'onion', 'garlic', 'ginger', 'bean', 'pea',
    'lettuce', 'spinach', 'kale', 'celery', 'asparagus', 'eggplant',
    'cardoon', 'head_cabbage',
    # Flowers
    'daisy', 'rose', 'sunflower', 'tulip', 'orchid', 'lily', 'lotus',
    'poppy', 'dandelion', 'violet', 'marigold', 'carnation', 'hyacinth',
    'jasmine', 'lavender', 'rapeseed', 'lady_slipper',
    # Trees & Woods
    'oak', 'pine', 'palm', 'willow', 'maple', 'bamboo', 'fern', 'moss',
    'conifer', 'acorn', 'nut', 'buckeye', 'chestnut', 'walnut', 'pecan',
    'seed', 'pod', 'cocoa', 'coffee',
    # Fungi
    'mushroom', 'fungus', 'fungi', 'toadstool', 'bolete', 'agaric',
    'gyromitra', 'stinkhorn', 'earthstar', 'hen-of-the-woods', 'coral_fungus'
]

# --- 2.1 Excluded Keywords (Fix False Positives) ---
EXCLUDED_KEYWORDS = [
    # Animals & Insects (substring matches)
    'bear', 'grasshopper', 'leafhopper', 'leaf_beetle', 'peacock', 
    'porcupine', 'bush_baby', 'sea_lion', 'hippopotamus', 'lionfish',
    'fruit_fly', 'monarch', 'bee_eater', 'ant',
    
    # Objects & Tools
    'coffee_mug', 'coffeepot', 'teapot', 'kettle', 'chamber_pot', 
    'crock_pot', 'melting_pot', 'inkpot', 'jackpot', 'flower_pot', # flower_pot usually implies plant, but can be empty. Keeping it for now if it causes issues.
    'spotlight', 'depot', 'earphone', 'hearing_aid', 'spear', 'pearl',
    'nutcracker', 'palm_pilot', 'plumber', 'street_sign',
    'pothole', 'traffic_light', 'limestone', 'soap_dispenser',
    
    # Food & Non-Plant Items
    'popcorn', 'donut', 'doughnut', 'pot_pie', 'meat_loaf', 'meatball',
    'carbonara', 'pizza', 'hamburger', 'hotdog', 'espresso', 'cappuccino',
    
    # Generic/Confusing terms & Partial matches
    'earth_mover', 'earthquake', 'heart', 'earring', 'gear', 'wear', 'tear',
    'mayflower', 'cup', 'mug', 'potter', 'pottery', 'spot', 'hotpot'
]

# --- 3. Detection Function ---
def PlantDetection(img_path):
    if not os.path.exists(img_path):
        return False, f"Error: File not found at {img_path}"

    try:
        # Load and preprocess
        img = image.load_img(img_path, target_size=(224, 224))
        x = image.img_to_array(img)
        x = np.expand_dims(x, axis=0)
        x = preprocess_input(x)

        # Predict
        preds = model.predict(x, verbose=0)
        decoded_preds = decode_predictions(preds, top=5)[0]
        
        is_plant = False
        detected_label = ""
        details = []

        # Analyze predictions
        for i, (imagenet_id, label, score) in enumerate(decoded_preds):
            details.append(f"{label} ({score:.2f})")
            label_lower = label.lower()
            
            # Check exclusions first
            if any(ex in label_lower for ex in EXCLUDED_KEYWORDS):
                continue

            # Keyword matching
            if any(k in label_lower for k in PLANT_KEYWORDS):
                is_plant = True
                detected_label = label
                break # Found a match
        
        # Result formatting
        if is_plant:
            return True, f"✅ Plant Detected: '{detected_label}'\n   (Top 5: {', '.join(details)})"
        else:
            return False, f"❌ No plant detected.\n   (Top 5: {', '.join(details)})"

    except Exception as e:
        return False, f"Error processing image: {str(e)}"

# --- 4. Main Execution (Example) ---
if __name__ == "__main__":
    # เปลี่ยน path ตรงนี้เป็นไฟล์รูปภาพของคุณ
    #test_image_path = r"test\test01.webp" 
    test_image_path = r"D:\Project\DCCE_CarbonPool\AiSpatialJupyter\Test\fd-04.webp" 
    
    # สร้างไฟล์ทดสอบจำลอง (ถ้าไม่มีรูป) เพื่อไม่ให้ code error
    if not os.path.exists(test_image_path):
        print(f"\n[Note] Please verify '{test_image_path}' exists. Skipping test run.")
    else:
        print(f"\nProcessing: {test_image_path} ...")
        result, message = PlantDetection(test_image_path)
        print("-" * 30)
        print(result, message)
        print("-" * 30)