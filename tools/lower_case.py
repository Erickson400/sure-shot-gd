import os

def lowercase_filenames(directory):
    for filename in os.listdir(directory):
        new_filename = filename.lower()
        if filename != new_filename:
            source_path = os.path.join(directory, filename)
            dest_path = os.path.join(directory, new_filename)
            os.rename(source_path, dest_path)

if __name__ == "__main__":
  lowercase_filenames("SFX/")






