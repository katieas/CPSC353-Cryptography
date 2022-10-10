'''
Name: Katie Stevens
Class: CPSC 353
Date Submitted: 1/29/2021
Assignment: Project 1
Descrition: Transposition Cipher
'''

import random
import string

'''
Pre: None
Post: generates and returns a randomized key of 26 letters.
'''
def key_gen():
    seed = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    key = random.sample(seed, 26)
    return key

'''
Pre: Given plain text to be encrypted and key
Post: Returns new encrypted text
'''
def encrypt(plain_txt, key):
    perm = [ord(x) - 64 for x in key]
    pln = str21st(plain_txt)
    plr = [perm[pln[i]] - 1 for i in range(len(plain_txt))]
    enc_txt = st2str(plr)
    print(enc_txt)
    return enc_txt

'''
Pre: Given encrypted text and key
Post: Returns decrypted text
'''
def decrypt(cipher_txt, key):
    perm = [ord(x) - 64 for x in key]
    invperm = Permutation(perm).inverse()
    plr = str21st(cipher_txt)
    pls = [invperm[plr[i]] - 1 for i in range(len(cipher_txt))]
    dec_txt = st2str(pls)
    print(dec_txt)
    return dec_txt

def str21st(s):
    return [ord(x) - 65 for x in s]

def st2str(st):
    return ''.join([chr(int(x) + 65) for x in st])