from PIL import Image
import os

def remove_purple_mask(image):
    data = image.getdata()
    new_data = []
    for item in data:
        if item[0] == 255 and item[1] == 0 and item[2] == 255:
            new_data.append((255, 255, 255, 0))
        else:
            new_data.append(item)
    image.putdata(new_data)


# Create directories
if not os.path.exists("converted_assets"):
    os.makedirs("converted_assets")
if not os.path.exists("converted_assets/bgs"):
    os.makedirs("converted_assets/bgs")
if not os.path.exists("converted_assets/gfx"):
    os.makedirs("converted_assets/gfx")


# Convert BGS
for file in os.listdir("sureshot_gamefiles/BGS"):
    img = Image.open("sureshot_gamefiles/BGS/"+file).convert("RGBA")
    remove_purple_mask(img)
    new_name = os.path.basename(file.lower()).split('.')[0] + ".png"
    img.save("converted_assets/bgs/"+new_name, "PNG")
    print("Converted "+file)
print("BGS Convertion Complete!")


# Convert GFX
for file in os.listdir("sureshot_gamefiles/GFX"):
    img = Image.open("sureshot_gamefiles/GFX/"+file).convert("RGBA")
    remove_purple_mask(img)
    new_name = os.path.basename(file.lower()).split('.')[0] + ".png"
    img.save("converted_assets/gfx/"+new_name, "PNG")
    print("Converted "+file)
print("GFX Convertion Complete!")

