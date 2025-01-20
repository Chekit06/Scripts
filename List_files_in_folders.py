import os

folders = input("Please provide folder names: ").split()
print(folders)

for folder in folders:

    try:
        files = os.listdir(folder)
    except FileNotFoundError:
        print("Please provide a valid folder name, looks like this folder doesnt exist - " + folder)
        continue
    except PermissionError:
        break
        print("No Access to this folder: " + folder)

    print("======Listing files for folders -" + folder)
    
    for file in files:
        print(file)