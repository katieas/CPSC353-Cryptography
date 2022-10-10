# Katie Stevens
# Project 9 - El Gamal
# CPSC 353 4/11/21

# Pre: size is an exponent, as in 2^size.
# Post: program returns El Gamal parameters, large prime, p and primitive root, a mod p as defined in class and in McAndrew
def param_gen(size):
    p = next_prime(2^size)
    a = mod(primitive_root(p), p)
    return p, a

# Pre: p and a are returned by param_gen
# Post: returns private key, A, and public key, B as defined in class and in McAndrew
def key_gen(p,a):
    import random
    A = randint(1, p)
    B = mod(a^A, p)
    return A, B

# Pre: a and p are  returned from param_gen, B from key_gen.  plaintext is a text string.  
#      Its numerical equivalent (see “Ancillary Functions,” below) must be less than p.
# Post: returns the encryption of plaintext C1 and C2, as defined in class and in McAndrew.
def encrypt(plaintext, a, p, B):
    m = txt_to_num(plaintext)
    if m < p:
        k = randint(1, p)
        C1 = mod(a^k, p)
        C2 = mod(B^k*m, p)
    else:
        quit()
    return C1, C2

# Pre: C1 and C2 form the ciphertext returned from encrypt, p is returned by gen_param,
#      A is the private key returned by key_gen, all as defined in class and in McAndrew.
# Post: returns the text string decryption of the ciphertext, using the El Gamal  algorithm
def decrypt(C1, C2, p, A):
    m = mod(C2/C1^A, p)
    m = num_to_txt(Integer(m))
    return m

def main():
    p, a = param_gen(100)
    A, B = key_gen(p, a)
    C1, C2 = encrypt("lucky", a, p, B)
    m = decrypt(C1, C2, p, A)
    print(m)


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