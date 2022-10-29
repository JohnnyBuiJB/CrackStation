# CrackStation

## Description
CrackStation is a Swift cryptography package that supports cracking SHA1 hashes. The package takes a SHA hash as input, then search it in pre-computed look up table. If the hash is found, it returns the corresponding password, otherwise it returns nil.

Currently, the package only supports cracking hashes of [A-Za-z0-9]{1,2}.

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


## How to use?
```swift
import CrackStation

let cs = CrackStation()
let password = cs.decrypt(shaHash:hash)
```



## Release
The current newest release is version **1.0.0**.

## Author
Vy Bui, 934370552, buivy@oregonstate.edu