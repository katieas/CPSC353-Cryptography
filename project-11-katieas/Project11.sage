# Name: Katie Stevens
# user: kstevens3
# Date: 4/20/21
# CPSC 353, Project 11

from sage.crypto.block_cipher.sdes import SimplifiedDES
sdes = SimplifiedDES()

def key_gen():
    return sdes.random_key()

def encrypt(pt, key):
    pt = sdes.string_to_list(pt)
    return sdes.list_to_string(sdes.encrypt(pt, key))

def decrypt(ct, key):
    ct = sdes.string_to_list(ct)
    return sdes.decrypt(ct, key)

def main():
    pt = [0,0,0,1,0,0,0,1]
    key = sdes.random_key()
    c = sdes.encrypt(pt, key)
    check = sdes.decrypt(c, key)
