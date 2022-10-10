# Katie Stevens
# Project 10 - Diffie-Hellman
# CPSC 353 4/11/21

# Pre: size is an exponent, as in 2^size.
# Post: program returns a large prime, p and a primitive root, g mod p
def param_gen(size):
    p = next_prime(2^size)
    g = mod(primitive_root(p), p)
    return p, g

# Pre: p, g are returned by param_gen
# Post: Returns computed A and and variable a, as defined in class and in McAndrew
def Alice(p,g):
    a = randint(1, p)
    A = mod(g^a, p)
    return a, A

# Pre: p, g are returned by param_gen
# Post: Returns computed B and variable b as  defined in class and in McAndrew
def Bob(p,g):
    b = randint(1, p)
    B = mod(g^b, p)
    return b, B

# Pre: p is returned by param_gen, a by Alice, and B by Bob
# Post: Returns kalice as defined in class and in McAndrew
def Alice_Key(p,a,B):
    kAlice = mod(B^a, p)
    return kAlice


# Pre: p is returned by param_gen, b by Bob, and A by Alice
# Post: Returns kBob as defined in class and in McAndrew
def Bob_Key(p,b,A):
    kBob = mod(A^b, p)
    return kBob

def main():
    p, g = param_gen(100)
    a, A = Alice (p,g)
    b, B = Bob(p,g)
    kAlice = Alice_Key(p,a,B)
    kBob = Bob_Key(p,b,A)
    print(kAlice == kBob)