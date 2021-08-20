import os
import glob
import time
from datetime import datetime

file1=open('../../../../labels.txt', 'r')
count=0

while True:
    count+=1
    line=file1.readline()
    if count==4:
        dataset_name=line
        print(dataset_name)
    if not line:
        break

file1.close()

os.chdir(dataset_name.split("\n")[0])
print(os.getcwd())

for image in glob.glob("*.png"):
    src = image
    dst = src.split(".")[0] + '.jpeg'
    os.rename(src, dst)

for image in glob.glob("*.jpg"):
        src = image
        dst = src.split(".")[0] + '.jpeg'
        os.rename(src, dst)

for x in glob.glob("*.xml"):
    file = open(x)
    data = file.read()
    file.close()
    data = data.replace(".jpg", ".jpeg")
    data = data.replace(".png", ".jpeg")
    file = open(x, "w+")
    file.write(data)
    file.close()
