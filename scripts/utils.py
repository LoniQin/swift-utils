import os
def get_files(source_path, filter):
    files = []
    current_root = ""
    for array in os.walk(source_path):
        for item in array:
            if type(item) == list:
                for element in item:
                    if filter(element) == True:
                        file_path = current_root + "/" + element
                        files.append(file_path)
            else:
                current_root = item
    return files