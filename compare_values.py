N = 2
BITS = 8

# takes in two files as input
# each line in both contains only bit characters (either '0' or '1'), followed by a '\n'
# `input.in`
# 	first 3 line contain the values of constants R, B, G respectively, each is 16 bits
# 	next N*N lines contain pixel values (in RGB order) in the problem statement order
# `output.in`
# 	N*N lines containing the output of our program
# internally, here the indexing is from (1, 1) to (100, 100)

def fill_pixels(PIXELS, LINES):

	row = 1
	col = 1
	increasing = True

	for i in range(N*N):
		PIXELS[row][col]['R'] = int(LINES[i][0:BITS], 2)
		PIXELS[row][col]['B'] = int(LINES[i][BITS:2*BITS], 2)
		PIXELS[row][col]['G'] = int(LINES[i][2*BITS:3*BITS], 2)

		if row == N and increasing :
			increasing = not increasing
			col += 1

		elif row == 0 and not increasing :
			increasing = not increasing
			col += 1

		else :
			if increasing:
				row += 1
			else:
				row -= 1

def check_pixel(i, j, verbose):

	iR = IPIXELS[i][j]['R']
	oR = OPIXELS[i][j]['R']
	iRu = IPIXELS[i-1][j]['R']
	iRd = IPIXELS[i+1][j]['R']
	iRl = IPIXELS[i][j-1]['R']
	iRr = IPIXELS[i][j+1]['R']

	iB = IPIXELS[i][j]['B']
	oB = OPIXELS[i][j]['B']
	iBu = IPIXELS[i-1][j]['B']
	iBd = IPIXELS[i+1][j]['B']
	iBl = IPIXELS[i][j-1]['B']
	iBr = IPIXELS[i][j+1]['B']

	iG = IPIXELS[i][j]['G']
	oG = OPIXELS[i][j]['G']
	iGu = IPIXELS[i-1][j]['G']
	iGd = IPIXELS[i+1][j]['G']
	iGl = IPIXELS[i][j-1]['G']
	iGr = IPIXELS[i][j+1]['G']

	status = True

	if verbose:
		print "R:", R, "G:", G, "B:", B
		print "IN \tR:",iR, "G:", iG, "B:", iB
		print "OUT \tR:",oR, "G:", oG, "B:", oB
		print ""
		print "UP \tR:",iRu, "G:", iGu, "B:", iBu
		print "DOWN  \tR:",iRd, "G:", iGd, "B:", iBd
		print "LEFT  \tR:",iRl, "G:", iGl, "B:", iBl
		print "RIGHT \tR:",iRr, "G:", iGr, "B:", iBr
		print ""

	oR_expected = round((iR*R + (2**BITS - R)*(float(iRu + iRr + iRl + iRd)/4))/2**BITS)
	oG_expected = round((iG*G + (2**BITS - G)*(float(iGu + iGr + iGl + iGd)/4))/2**BITS)
	oB_expected = round((iB*B + (2**BITS - B)*(float(iBu + iBr + iBl + iBd)/4))/2**BITS)

	if oR_expected != oR:
		if verbose:
			print "R value does not match!\n"
		status = False

	if oG_expected != oG:
		if verbose:
			print "G value does not match!\n"
		status = False

	if oB_expected != oB:
		if verbose:
			print "B value does not match!\n"
		status = False

	if status:
		print "Output is as expected!\n"
	return status

def check_all():

	for i in range(1, N+1):
		for j in range(1, N+1):

			if not check_pixel(i, j, False):
				return False

	return True


f = open("input.in")
in_lines = f.read().split('\n')[:-1]
f.close()

R = int(in_lines[0], 2)
G = int(in_lines[1], 2)
B = int(in_lines[2], 2)

in_lines = in_lines[3:]

IPIXELS = [[{'R':0, 'G':0, 'B':0} for j in range(N+2)] for i in range(N+2)]
fill_pixels(IPIXELS, in_lines)

f = open("output.in")
out_lines = f.read().split('\n')[:-1]
f.close()

OPIXELS = [[{'R':0, 'G':0, 'B':0} for j in range(N+2)] for i in range(N+2)]
fill_pixels(OPIXELS, out_lines)

if check_all():
	print "\nAll pixels match!"
else:
	print "\nPixels don't match!"

print "\nManual checking!"
while(True):
	row = int(raw_input("Row [1 to N] :"))
	col = int(raw_input("Col [1 to N] :"))

	check_pixel(row, col, True)
