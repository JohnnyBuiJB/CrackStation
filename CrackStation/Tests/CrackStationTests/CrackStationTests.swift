import XCTest
import CryptoKit
import Foundation
@testable import CrackStation

final class CrackStationTests: XCTestCase {
    func testLowerCaseLetters() async {
        // Given
        for char in "abcdefghijklmnopqrstuvwxyz" {
            let expSHA1 = encryptUsingSha1(from: String(char))
            var actSHA1:String?

            let cs = CrackStation()

            // When
            let hash = cs.decrypt(shaHash:String(char))

            if hash != nil {
                actSHA1 = hash!
            }

            // Then
            XCTAssert(actSHA1 == expSHA1)
        }
    }

    func testUpperCaseLetters() async {
        // Given
        for char in "ABCDEFGHIJKMNOPQRSTUVWXYZ" {
            let expSHA1 = encryptUsingSha1(from: String(char))
            var actSHA1:String?

            let cs = CrackStation()

            // When
            let hash = cs.decrypt(shaHash:String(char))

            if hash != nil {
                actSHA1 = hash!
            }
            
            // Then
            XCTAssert(actSHA1 == expSHA1)
        }
    }

    func testUpperDecimalDigits() async {
        // Given
        for digit in 0...9 {
            let expSHA1 = encryptUsingSha1(from: String(digit))
            var actSHA1:String?

            let cs = CrackStation()

            // When
            let hash = cs.decrypt(shaHash:String(digit))

            if hash != nil {
                actSHA1 = hash!
            }

            // Then
            XCTAssert(actSHA1 == expSHA1)
        }
    }

    func testUnsupportedPassword() async {
       // Given
       let cs = CrackStation()
       var actSHA1:String?

       // When
        let hash = cs.decrypt(shaHash:String("abcde"))

        if hash != nil {
            actSHA1 = hash!
        }

       // Then
       XCTAssertNil(actSHA1)
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

