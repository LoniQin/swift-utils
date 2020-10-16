
//
//  SymmetricCipherTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class SymmetricCipherTestCase: XCTestCase {
    
    func testBruteForce() throws {
        let texts = ["🐱🐱🐱", "Hello world", ""]
        do {
            for text in texts {
                for algorithm in SymmetricCipher.Algorithm.allCases {
                    for mode in SymmetricCipher.Mode.allCases {
                        for padding in SymmetricCipher.Padding.allCases {
                            let key = try algorithm.randomKey()
                            let iv = mode.needsIV() ? algorithm.randomIV() : Data()
                            let cipher = SymmetricCipher(algorithm, key: key, iv: iv, padding: padding, mode: mode)
                            if cipher.isValid {
                                let data = text.data(using: .utf8)!
                                let encrypted = try cipher.process(.encrypt, data)
                                let decrypted = try cipher.process(.decrypt, encrypted)
                                XCTAssert(data == decrypted)
                            }
                        }
                    }
                }
            }
        } catch let error {
            objc_exception_throw(error)
        }
    }
    
    func testSymmetricCipherWithHelloWorld() throws {
        let plainText = "Hello world"
        print("Plain text: \(plainText)")
        print("-----------------------------------------------------")
        for algorithm in SymmetricCipher.Algorithm.allCases {
            for mode in SymmetricCipher.Mode.allCases {
                let key = try algorithm.randomKey()
                let iv = mode.needsIV() ? algorithm.randomIV() : Data()
                let cipher = SymmetricCipher(algorithm, key: key, iv: iv, mode: mode)
                if cipher.isValid {
                    let data = plainText.data(using: .utf8)!
                    let encrypted = try cipher.process(.encrypt, data)
                    print("Algorithm: \(String(describing: algorithm).uppercased())")
                    print("Mode: \(String(describing: mode).uppercased())")
                    print("key: \(key.hex)")
                    if mode.needsIV() {
                        print("iv: \(iv.hex)")
                    }
                    print("Cipher text: \(encrypted.hex)")
                    let decrypted = try cipher.process(.decrypt, encrypted)
                    print("-----------------------------------------------------")
                    XCTAssert(decrypted == data)
                }
            }
        }
    }
    
    func testInRandom() throws {
        for algorithm in SymmetricCipher.Algorithm.allCases {
            for mode in SymmetricCipher.Mode.allCases {
                for padding in SymmetricCipher.Padding.allCases {
                   
                    let key = try algorithm.randomKey()
                    let iv = mode.needsIV() ? algorithm.randomIV() : Data()
                    let cipher = SymmetricCipher(algorithm, key: key, iv: iv, padding: padding, mode: mode)
                    if algorithm.isValid(mode: mode, padding: padding) {
                        let data = Data(random: Int(arc4random()) % 1000)
                        let encrypted = try cipher.process(.encrypt, data)
                        let decrypted = try cipher.process(.decrypt, encrypted)
                        XCTAssert(data == decrypted)
                    }
                }
            }
        }
    }

    func testIsAlgorithmVaild() throws {
        XCTAssertTrue(SymmetricCipher.Algorithm.aes.isValid(mode: .ctr, padding: .pkcs7))
    }
    
    func testAES128() throws {
        let algorithm = SymmetricCipher.Algorithm.aes
        let plainText = "Hello world"
        let data = try plainText.data(.utf8)
        let key = try String(repeating: "1", count: SymmetricCipher.Algorithm.KeySize.aes128).data(.ascii)
        let iv = try String(repeating: "1", count: algorithm.blockSize).data(.ascii)
        let aes = SymmetricCipher(.aes, key: key, iv: iv)
        let encrypted = try aes.encrypt(data)
        print("Cipher text: \(try encrypted.string(.hex))")
        let decrypted = try aes.decrypt(encrypted)
        XCTAssert(data == decrypted)
    }
    
    func testAES192() throws {
        let algorithm = SymmetricCipher.Algorithm.aes
        let plainText = "Hello world"
        let data = try plainText.data(.utf8)
        let key = try String(repeating: "1", count: SymmetricCipher.Algorithm.KeySize.aes192).data(.ascii)
        let iv = try String(repeating: "1", count: algorithm.blockSize).data(.ascii)
        let aes = SymmetricCipher(.aes, key: key, iv: iv)
        let encrypted = try aes.encrypt(data)
        print("Cipher text: \(try encrypted.string(.hex))")
        let decrypted = try aes.decrypt(encrypted)
        XCTAssert(data == decrypted)
    }
    
    func testAES256() throws {
        let plainText = "Hello world"
        let data = try plainText.data(.utf8)
        let key = try String(repeating: "1", count: 32).data(.ascii)
        let iv = try String(repeating: "1", count: 16).data(.ascii)
        let aes = SymmetricCipher(.aes, key: key, iv: iv)
        let encrypted = try aes.encrypt(data)
        print("Cipher text: \(try encrypted.string(.hex))")
        let decrypted = try aes.decrypt(encrypted)
        XCTAssert(data == decrypted)
    }
    
    func testSHA256() throws {
        let plainText = "Hello world"
        let data = try plainText.data(.utf8)
        let digest = try Digest.sha256.process(data).string(.hex)
        print("Plain text: \(plainText)")
        print("SHA256: \(digest)")
    }
    
    func testIVSize() {
        XCTAssertEqual(SymmetricCipher.Algorithm.aes.keySizes(), [16, 24, 32])
        XCTAssertEqual(SymmetricCipher.Algorithm.aes.ivSize(mode: .cbc), 16)
        XCTAssertEqual(SymmetricCipher.Algorithm.aes.ivSize(mode: .ecb), 0)
        XCTAssertTrue(SymmetricCipher.Algorithm.aes.isValidKeySize(32))
        XCTAssertFalse(SymmetricCipher.Algorithm.aes.isValidKeySize(40))
    }
    
    func testIsIVNeeded() {
        SymmetricCipher.Mode.cbc.needsIV().assert.true()
        SymmetricCipher.Mode.ecb.needsIV().assert.false()
    }
    
    
}
