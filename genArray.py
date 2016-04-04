import tifffile as tiff
import sys
import numpy as np

if(len(sys.argv) != 2):
	sys.exit()

a = tiff.imread(sys.argv[1])

b = []

for i,row in enumerate(a):
	c = []
	for j,col in enumerate(row):
		c.append([np.binary_repr(x,width=16) for x in a[i][j]])
	b.append(c)

stri = "wait for clk_period*1\n"
pix = "Pixel"
color = ['RPixel','GPixel','BPixel']
with open('inp.txt','w') as f:
	for row in b:
		for col in row:
			s = ""
			s += stri
			# s += "start<='0';\n"
			for i,val in enumerate(col):
				s += color[i] + "<=" + '"' + str(val) + '"\n'
			f.write(s)

# tiff.imsave('new.tiff', a)