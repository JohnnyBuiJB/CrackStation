# CrackStation

## Description
CrackStation is a Swift cryptography package that supports cracking SHA1 hashes. The package takes a SHA hash as input, then search it in pre-computed look up table. If the hash is found, it returns the corresponding password, otherwise it returns nil.

## APIs
**required init()**
- Description: initialize the crack station
- Parameter: none
- Throws: none
- Returns: none

**func decrypt(shaHash: String) -> String?**
- Description: crack the provided hash shaHash
- Parameter:
  - shaHash: String (input): hashed to be decrypted
- Throws: none
- Returns: the corresponding password if the function succeeds, otherwise return nil

## Author
Vy Bui, 934370552, buivy@oregonstate.edu