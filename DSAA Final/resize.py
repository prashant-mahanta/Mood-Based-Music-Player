import PIL
from PIL import Image
print("Enter file name with extension(.png,.jpeg)")
i=1
for j in range(1,101):
    file=str(i)+'.jpg'
    print("Enter the size (width x length pixels)format without any spaces")
    a='200x149'
    a=a.split("x")
    basewidth=int(a[0])
    hsize=int(a[1])
    img=Image.open(file)
    img=img.resize((basewidth,hsize),(PIL.Image.ANTIALIAS))
    img.save(file)
    i+=1
