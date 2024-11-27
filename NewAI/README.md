GENERAL GUIDELINES
-try to have at least 30 images per class (object)

STEPS TO MAKE A NEW MODEL
1. make sure you have every image you want in the images folder in the correct subfolders
2. in the terminal, activate the venv
    - 'ls' command will list the files you can currently reach from terminal
    - cd [path] is to change directory (cd .. to go up a level)
    - to activate the venv on mac, enter the following: `source venv/bin/activate`, you will know it worked if you see the (venv) at the from of the command line
3. to generate the dataset, run organizer.py with the following command:
    - `python3 dataset.py`
    - NOTE: remember to delete the old dataset before running dataset.py
4. to train the model, run `python3 train.py`