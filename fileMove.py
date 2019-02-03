import glob
import os

#       old method , kept just in case
# list_of_files = glob.glob('E:\\ShareX\\Screenshots\\*') # * means all if need specific format # then *.csv
# latest_file = max(list_of_files, key=os.path.getctime)
# print (latest_file)

try:
    os.remove("E:\\ahkocr\\images\\relicScreen.png")
except FileNotFoundError:
    print("deleting error ignored")

try:
    os.rename("E:\\ShareX\\Screenshots\\newScreenshot.png", "E:\\ahkocr\\images\\relicScreen.png")
except FileNotFoundError:
    print("moving error ignored")


print("done")
exit()







