# Name: Katie Stevens
# CPSC 353 Project 12

def padding(message):
	message_bytes = bytearray(message, 'utf-8')
	padding = 16 - (len(message_bytes) % 16)
	message_bytes += bytearray(padding for _ in range(padding))
	return message_bytes

def checksum(message_bytes, S):
	C = [0] * 16
	N = len(message_bytes)
	L = 0
	M = message_bytes
	for i in range(N // 16):
		for j in range(16):
			c = M[16*i+j]
			C[j] = C[j] ^^ S[c ^^ L]
			L = C[j]
	M = list(M)
	M += C
	return M

def hash(message_bytes, S):
	X = [0] * 48
	N = len(message_bytes)
	M = message_bytes
	for i in range(N // 16):
		for j in range(16):
			X[j+16] = M[16*i+j]
			X[j+32] = X[j+16] ^^ X[j]
	t = 0
	for j in range(18):
		for k in range(48):
			t = X[k] ^^ S[t]
			X[k] = t
		t = (t+j)%256
	msg = []
	for i in range(0, 16):
		msg.append(chr(X[i] % 26 + 65))
	return msg

def make_S():
	S = [i for i in range(256)]
	pistr = str(numerical_approx(pi, digits=1000))
	digits = [int(S) for S in pistr if S != "."]
		
	k = 2
	while k < 257:
		j = rand(k, digits)
		temp = S[j]
		S[j] = S[k - 1]
		S[k - 1] = temp
		k += 1
		
	return S

def rand(n, digits):
	x = next(iter(digits))
	y = 10
	if n > 10:
		x = x * 10 + next(iter(digits))
		y = 100
	if n > 100:
		x = x * 10 + next(iter(digits))
		y = 1000
	
	if x < (n * (y // n)):
		return x % n
	else:
		return rand(n)

def md2(message):
	message_bytes = padding(message)
	print(message_bytes)
	S = make_S()
	message_bytes = checksum(message_bytes, S)
	msg = hash(message_bytes, S)
	print(msg)
