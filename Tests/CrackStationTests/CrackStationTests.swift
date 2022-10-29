import XCTest
import CryptoKit
import Foundation
@testable import CrackStation

final class CrackStationTests: XCTestCase {
    func testLowerCaseLetters() async {
        let cs = CrackStation()
        
        for password in "abcdefghijklmnopqrstuvwxyz" {
            // Given
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

    func testUpperCaseLetters() async {
        let cs = CrackStation()
        
        for password in "ABCDEFGHIJKMNOPQRSTUVWXYZ" {
            // Given
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
    
    func testUpperDecimalDigits() async {
        let cs = CrackStation()
        
        for password in 0...9 {
            // Given
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

    func testUnsupportedPassword() async {
       // Given
       let cs = CrackStation()
       var actSHA1:String = ""

       // When
        let hash = cs.decrypt(shaHash:String("aa"))

        if hash != nil {
            actSHA1 = hash!
        }

       // Then
       XCTAssert(actSHA1 == "")
    }
    
    func testTwoLetterPassword() async {
        let cs = CrackStation()
        
        for l1 in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKMNOPQRSTUVWXYZ0123456789" {
            for l2 in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKMNOPQRSTUVWXYZ0123456789" {
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
    
}

/// Input: a string.
/// Output: the string encrypted using the SHA-1 algorithm.
func encryptUsingSha1(from input: String) -> String {
    let inputData = Data(input.utf8)
    let output = Insecure.SHA1.hash(data: inputData)
    let hashString = output.compactMap { String(format: "%02x", $0) }.joined()
    return hashString
}

