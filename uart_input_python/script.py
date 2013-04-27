import serial
s = serial.Serial(port='COM18',baudrate=38400)

def sort(inpFile):
	a = map(lambda x: int(x), file(inpFile).read().strip().split('\n'))
	out =[]
	for n in a:
		s.write(chr((n/(2**24))%256))
		s.write(chr((n/(2**16))%256))
		s.write(chr((n/(2**8))%256))
		s.write(chr(n%256))

	print '\n'
	print "Input: ",a
	for i in range(0,len(a)):
		n = ord(s.read())
		n = ord(s.read()) + n*256
		n = ord(s.read()) + n*256
		n = ord(s.read()) + n*256
		if n >= 2**31:
			n = n - 2**32
		out.append(int(n))
	print "Output:",out

s.timeout = 2
sort('input.txt')
s.timeout = 30
