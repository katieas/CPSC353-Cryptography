'''
Name: Katie Stevens
Assignment: Project 7
'''


# Pre: size is an exponent, as in 2^size.
# Post: program returns the RSA public key,(n,e)  and the private key, d. 
# Comments: e is prime and of the 2^r + 1, where r is an integer. It does not have to be large. 17 is a reasonable 
# choice, though you might impress me by generating one in the proper form. n, d are generated according to the RSA algorithm.
def key_gen(size):
    import random
    import math
    p = next_prime(random.randint(2 ** size,2 ** (size + 100)))
    q = next_prime(random.randint(2 ** size,2 ** (size + 100)))
    n = p * q
    e = 17
    phi = (p - 1) * (q - 1)

    bezout = xgcd(e, phi)
    d = Integer(mod(bezout[1], phi))

    return n, e, d

# Pre: plain_text is a text string, chosen by the user.  “Than you can understand,” is an example.  There are no limits on its size.  e, n are returned by key_gen 
# Post: returns the encryption of plain_text, using the RSA algorithm.
def encrypt(plain_text, e, n):
    m = txt_to_num(plain_text)
    digits = int(len(str(n)) - 1)
    block = split(m, digits)
    for i in range(len(block)):
        block[i] = power_mod(block[i], e, n)
    return block

def split(m, digit):
    block = []
    div = 10 ** digit
    if (div == 1):
        div = 10
    while (m > 0):
        curr = m % div
        block.insert(0, curr)
        m = m // div
    return block

# Pre: d, n are returned by key_gen.  c is returned by encrypt.
# Post: returns the decryption of the cipher_text, using the RSA algorithm
def decrypt(c,d,n):
    for i in range(len(c)):
        c[i] = power_mod(c[i], d, n)
        c[i] = num_to_txt(c[i])
    m = "".join(c)
    return m

#Converts a string to a decimal digit sequence
#msg_in is a string
def txt_to_num(msg_in):      
  #transforms string to the indices of each letter in the 8-bit ASCII table
  #ex: "AB" becomes [65,66]
  msg_idx = list(map(ord,msg_in))

  #The integers in the list, since they are ASCII, are in the range 0..255
  #These are treated, collectively, as a base 256 integer, but from left to right
  #rather than right to left
  #This sequence of integers is converted to base 10 
  #ex: [65,66] = 65*256^0 + 66*256^1 = 16961
  num = ZZ(msg_idx,256)
  return num 

#Converts a digit sequence to a string
#num_in is a decimal integer, constructed from a string using txt_to_num 
def num_to_txt(num_in):
  #transforms the base 10 num_in to a list of base 256 digits. 256^0 is on the left 
  msg_idx = num_in.digits(256)

  #maps each index to its associated character in the ascii table 
  m = map(chr,msg_idx)

  #transforms the list to a string
  m = ''.join(m)
  return m

def main():
    n, e, d = key_gen(100)
    ct = encrypt("chicken", e, n)
    message = decrypt(ct, d, n)
    print(message)

main()