import os
import shutil
import random

def generate_label_file(image_path, class_id, label_dest_dir):
    label_file_path = os.path.join(label_dest_dir, os.path.basename(image_path).replace('.jpg', '.txt'))
    with open(label_file_path, 'w') as label_file:
        # YOLO format: class_id center_x center_y width height
        # Assuming the entire image is the object (0.5 0.5 1 1 for full image)
        label_file.write(f"{class_id} 0.5 0.5 1 1\n")

def split_dataset(source_dir, dest_dir, class_names, train_ratio=0.7, val_ratio=0.2, test_ratio=0.1):
    # Ensure destination directories exist
    for split in ['train', 'validation', 'test']:
        os.makedirs(os.path.join(dest_dir, split), exist_ok=True)

    class_to_id = {class_name: idx for idx, class_name in enumerate(class_names)}

    # Iterate over each class folder
    for class_folder in os.listdir(source_dir):
        class_path = os.path.join(source_dir, class_folder)
        
        if os.path.isdir(class_path):
            all_files = [f for f in os.listdir(class_path) if f.endswith('.jpg')]  # Adjust if using different image formats
            random.shuffle(all_files)

            train_split = int(len(all_files) * train_ratio)
            val_split = train_split + int(len(all_files) * val_ratio)

            train_files = all_files[:train_split]
            val_files = all_files[train_split:val_split]
            test_files = all_files[val_split:]

            class_id = class_to_id[class_folder]

            # Ensure class folders exist in destination splits
            for split in ['train', 'validation', 'test']:
                os.makedirs(os.path.join(dest_dir, split, class_folder), exist_ok=True)

            # Copy files to respective directories and generate label files
            for files, split in [(train_files, 'train'), (val_files, 'validation'), (test_files, 'test')]:
                for file in files:
                    src_file_path = os.path.join(class_path, file)
                    dest_file_path = os.path.join(dest_dir, split, class_folder, file)
                    shutil.copy(src_file_path, dest_file_path)
                    generate_label_file(dest_file_path, class_id, os.path.join(dest_dir, split, class_folder))

# Paths
source_directory = 'images'
destination_directory = 'dataset'
class_names = ['apple', 'orange', 'banana', 'strawberry', 'blueberry', 'none']  # List your class names here

# Perform the dataset split
split_dataset(source_directory, destination_directory, class_names)