# CrackStation, a Decrypter implementation
A decryption library.

## Overview
CrackStation is a Swift cryptography package that supports cracking SHA hashes. The library takes an SHA hash as input, then search it in pre-computed look up table. If the hash is found, it returns the corresponding password, otherwise it returns nil.

Currently, the library only supports cracking SHA-1 or hashes of [A-Za-z0-9?!]{1,2,3} and unsalted passwords.

## Mission Statement
This library is primarily meant to demonstrate the vulnerability of password storage systems using non-salted hashing, hence encourage authentication system implementors to search for better solutions. That would help improve the cyberspace security in general.

## Installation
### Swift Package Manager
The [Swift Package Manager](https://www.swift.org/package-manager/) is "a tool for managing the distribution of Swift code. It's integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies."

Once you have your Swift package manager set up, add CrackStation to the list of dependencies in your Package.swift file

```package.swift
dependencies: [
    .package(url: "https://github.com/JohnnyBuiJB/CrackStation.git", .upToNextMajor(from: "1.1.0"))
]
```

## Usage
### The API
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


## An example?
```swift
import CrackStation

let cs = CrackStation()
let password = cs.decrypt(shaHash:hash)
```



## Release
The current newest release is version **1.0.0**.

## Author
Vy Bui, 934370552, buivy@oregonstate.edu