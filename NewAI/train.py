from ultralytics import YOLO
import torch
import torchvision

def main():
    # print("Torch version:", torch.__version__)
    # print("Torchvision version:", torchvision.__version__)
    # print("CUDA available:", torch.cuda.is_available())
    # print("Number of GPUs:", torch.cuda.device_count())
    # print("Current GPU:", torch.cuda.current_device())
    # print("GPU Name:", torch.cuda.get_device_name(torch.cuda.current_device()))

    # # Verify if CUDA is available
    # if torch.cuda.is_available():
    #     device = 'cuda'
    # else:
    #     device = 'cpu'
    #     print("CUDA not available, using CPU")

    # Define paths
    data_config_path = 'data.yaml'
    model_save_path = 'model.pt'

    # Initialize and train the YOLO model
    model = YOLO("yolov8n.pt")
    model.train(data=data_config_path, epochs=50, batch=16, imgsz=640, device="mps")

    # Evaluate model
    results = model.val(data=data_config_path, device="mps")
    metrics = results.results_dict  # Get the results dictionary

    accuracy = metrics['metrics/precision(B)']  # Adjust to the correct metric key if needed
    print(f'Validation Precision: {accuracy * 100:.2f}%')

    # Save the trained model
    model.save(model_save_path)

if __name__ == "__main__":
    main()