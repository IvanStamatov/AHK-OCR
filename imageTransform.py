from PIL import Image, ImageEnhance 
import os


im = Image.open("images\\relicScreen.jpg")
enhancer = ImageEnhance.Brightness(im)
enhanced_im = enhancer.enhance(0.4)
enhanced_im.save("images\\relicScreenBR.jpg")

im = Image.open("images\\relicScreenBR.jpg")
enhancer = ImageEnhance.Contrast(im)
enhanced_im = enhancer.enhance(6.0)
enhanced_im.save("images\\relicScreen.jpg")

os.remove("images\\relicScreenBR.jpg")

print("image transformed")
exit()