from roboflow import Roboflow
from config import *

# Download the dataset
rf = Roboflow(api_key=ROBOFLOW_API_KEY)
project = rf.workspace("danika").project("properplates")
version = project.version(2)
dataset = version.download("yolov8")
