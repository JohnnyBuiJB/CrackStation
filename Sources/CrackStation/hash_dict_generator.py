import hashlib
import json
from string import ascii_lowercase, ascii_uppercase
import os

def main():
    cur_dir = os.getcwd()
    
    dict = {}
    alphabet = ascii_lowercase + ascii_uppercase + "0123456789?!"
    
    for c in alphabet:
        dict[hashlib.sha1(c.encode('utf-8')).hexdigest()] = c
        dict[hashlib.sha256(c.encode('utf-8')).hexdigest()] = c
    
    for c1 in alphabet:
        for c2 in alphabet:
            dict[hashlib.sha1((c1 + c2).encode('utf-8')).hexdigest()] = (c1 + c2)
            dict[hashlib.sha256((c1 + c2).encode('utf-8')).hexdigest()] = (c1 + c2)
    
    for c1 in alphabet:
        for c2 in alphabet:
            for c3 in alphabet:
                dict[hashlib.sha1((c1 + c2 + c3).encode('utf-8')).hexdigest()] = (c1 + c2 + c3)
                dict[hashlib.sha256((c1 + c2 + c3).encode('utf-8')).hexdigest()] = (c1 + c2 + c3)
    
    with open(cur_dir + "/HashDict.json", "w") as file:
        file.write(json.dumps(dict, indent=4))

if __name__ == "__main__":
    main()
