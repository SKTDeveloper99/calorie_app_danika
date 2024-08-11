import math
from flask import Flask, request, jsonify
import flask_cors
import base64
import numpy as np
import cv2
from ultralytics import YOLO

app = Flask(__name__)
flask_cors.CORS(app)

model_path = 'model.pt'
model = YOLO(model_path)

# http://192.168.0.120:8000/process_image
# https://calorie-app-danika.onrender.com/process_image

@app.route('/')
def hello_world():
    return 'Hello, World!'

def convertBase64ToImage(base64_string):
    # # # Convert base64 string to numpy array
    # img_data = base64.b64decode(base64_string)
    # nparr = np.frombuffer(img_data, np.uint8)
    # # Convert numpy array to image
    # return cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    nparr = np.frombuffer(base64.b64decode(base64_string), np.uint8)
    image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return image

def convertImageToBase64(image):
    # Convert image to numpy array
    _, buffer = cv2.imencode('.jpg', image)
    # Convert numpy array to base64 string
    return base64.b64encode(buffer).decode("utf-8")

@app.route('/process_image', methods=['POST'])
def process_image():
    try:
        data = request.get_json()
        base64_image = data['image']

        image = convertBase64ToImage(base64_image)

        # Process image with AI here
        identifiedObject = ""
        # Load model

        # object classes
        # classNames = ["person", "bicycle", "car", "motorbike", "aeroplane", "bus", "train", "truck", "boat",
        #       "traffic light", "fire hydrant", "stop sign", "parking meter", "bench", "bird", "cat",
        #       "dog", "horse", "sheep", "cow", "elephant", "bear", "zebra", "giraffe", "backpack", "umbrella",
        #       "handbag", "tie", "suitcase", "frisbee", "skis", "snowboard", "sports ball", "kite", "baseball bat",
        #       "baseball glove", "skateboard", "surfboard", "tennis racket", "bottle", "wine glass", "cup",
        #       "fork", "knife", "spoon", "bowl", "banana", "apple", "sandwich", "orange", "broccoli",
        #       "carrot", "hot dog", "pizza", "donut", "cake", "chair", "sofa", "pottedplant", "bed",
        #       "diningtable", "toilet", "tvmonitor", "laptop", "mouse", "remote", "keyboard", "cell phone",
        #       "microwave", "oven", "toaster", "sink", "refrigerator", "book", "clock", "vase", "scissors",
        #       "teddy bear", "hair drier", "toothbrush"
        # ]

        # Inference
        results = model([image])

        # Extract predictions
        predictions = results[0].boxes  # Assuming 'results[0].boxes' contains the bounding boxes and labels


        for pred in predictions:
            identifiedObject = model.names[int(pred.cls)]

        # DEBUG: Save image to disk
        # cv2.imwrite('test.jpg', image)

        print('Identified object:', identifiedObject)

        return jsonify({'identified': identifiedObject}), 200
    except Exception as e:
        print(e)
        return jsonify({'message': 'Error processing image'}), 500
    # return 'Image processed!'

@app.route('/get_privacy_policy', methods=['GET'])
def get_privacy_policy():
    return 'Privacy policy'

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8000)