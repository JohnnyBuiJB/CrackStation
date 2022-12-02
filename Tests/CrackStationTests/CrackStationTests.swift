import XCTest
import CryptoKit
import Foundation
import CrackStation

let supportedSymbol = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789?!"

final class CrackStationTests: XCTestCase {
    func testOneLetterPasswordFromSHA1() async {
        let cs = CrackStation()
        
        for l1 in supportedSymbol {
            print(l1)
            // Given
            let password = String(l1)
                
            let Sha1Hash = encryptUsingSha1(from: String(password))
            var crackedPassword:String = ""

            // When
            let result = cs.decrypt(shaHash:Sha1Hash)

            if result != nil {
                crackedPassword = result!
            }

            // Then
            XCTAssert(crackedPassword == String(password))
        }
    }

    func testTwoLetterPasswordFromSHA1() async {
        let cs = CrackStation()
        
        for l1 in supportedSymbol {
            for l2 in supportedSymbol {
                // Given
                let password = String(l1) + String(l2)
                
                let hash = encryptUsingSha1(from: String(password))
                var crackedPassword:String = ""

                // When
                let result = cs.decrypt(shaHash:hash)

                if result != nil {
                    crackedPassword = result!
                }

                // Then
                XCTAssert(crackedPassword == String(password))
            }
        }
    }

    func testThreeLetterPasswordFromSHA1() async {
        let cs = CrackStation()
        
        for l1 in supportedSymbol {
            for l2 in supportedSymbol {
                for l3 in supportedSymbol {
                    // Given
                    let password = String(l1) + String(l2) + String(l3)
                    
                    let hash = encryptUsingSha1(from: String(password))
                    var crackedPassword:String = ""

                    // When
                    let result = cs.decrypt(shaHash:hash)

                    if result != nil {
                        crackedPassword = result!
                    }

                    // Then
                    XCTAssert(crackedPassword == String(password))
                }
            }
        }
    }

    func testOneLetterPasswordFromSHA256() async {
        let cs = CrackStation()
        
        for l1 in supportedSymbol {
            print(l1)
            
            // Given
            let password = String(l1)
                
            let Sha1Hash = encryptUsingSha256(from: String(password))
            var crackedPassword:String = ""

            // When
            let result = cs.decrypt(shaHash:Sha1Hash)

            if result != nil {
                crackedPassword = result!
            }

            // Then
            XCTAssert(crackedPassword == String(password))
        }
    }
    
    func testTwoLetterPasswordFromSHA256() async {
        let cs = CrackStation()
        
        for l1 in supportedSymbol {
            for l2 in supportedSymbol {
                // Given
                let password = String(l1) + String(l2)
                
                let hash = encryptUsingSha256(from: String(password))
                var crackedPassword:String = ""

                // When
                let result = cs.decrypt(shaHash:hash)

                if result != nil {
                    crackedPassword = result!
                }

                // Then
                XCTAssert(crackedPassword == String(password))
            }
        }
    }

    func testThreeLetterPasswordFromSHA256() async {
        let cs = CrackStation()
        
        for l1 in supportedSymbol {
            for l2 in supportedSymbol {
                for l3 in supportedSymbol {
                    // Given
                    let password = String(l1) + String(l2) + String(l3)
                    
                    let hash = encryptUsingSha256(from: String(password))
                    var crackedPassword:String = ""

                    // When
                    let result = cs.decrypt(shaHash:hash)

                    if result != nil {
                        crackedPassword = result!
                    }

                    // Then
                    XCTAssert(crackedPassword == String(password))
                }
            }
        }
    }

    func testUnsupportedPassword() async {
        // Given
        let cs = CrackStation()

        // When
        let Sha1hash = encryptUsingSha1(from: String("MessiIsTheGoat"))
        let Sha1Result = cs.decrypt(shaHash:Sha1hash)

        // Then
        XCTAssert(Sha1Result == nil)

        // When
        let Sha256hash = encryptUsingSha256(from: String("MessiIsTheGoat"))
        let Sha256Result = cs.decrypt(shaHash:Sha256hash)

        // Then
        XCTAssert(Sha256Result == nil)
    }
}

/// Input: a string.
/// Output: the string encrypted using the SHA-1 algorithm.
func encryptUsingSha1(from input: String) -> String {
    let inputData = Data(input.utf8)
    let output = Insecure.SHA1.hash(data: inputData)
    let hashString = output.compactMap { String(format: "%02x", $0) }.joined()
    return hashString
}

/// Input: a string.
/// Output: the string encrypted using the SHA-256 algorithm.
func encryptUsingSha256(from input: String) -> String {
    let inputData = Data(input.utf8)
    let output = SHA256.hash(data: inputData)
    let hashString = output.compactMap { String(format: "%02x", $0) }.joined()

    return hashString
}
