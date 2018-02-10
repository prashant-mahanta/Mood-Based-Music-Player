f = open('testimage.txt','a')
for i in range(1,101):
	if i < 10:
		f.write("Image00%d.jpg,neutral\n" %i)
	else:
		if i>=10 and i<=20:
			f.write("Image0%d.jpg,neutral\n"%i)
		elif i>=21 and i<=40:
			f.write("Image0%d.jpg,happy\n"%i)
		elif i>=41 and i<=60:
			f.write("Image0%d.jpg,angry\n"%i)
		elif i>=61 and i<=80:
			f.write("Image0%d.jpg,digust\n"%i)
		else :
			f.write("Image0%d.jpg,sad\n"%i)
f.close()
