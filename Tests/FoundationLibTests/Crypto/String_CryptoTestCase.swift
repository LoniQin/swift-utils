
//
//  String_CryptoTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class String_CryptoTestCase: XCTestCase {
    
    func testStringProcessWithCipher() throws {
        let plainText = "I am fine"
        let key = "1111111111111111"
        let iv = "1111111111111111"
        let cipherText = try plainText.process(.init(.encrypt(.aes), [.key: key, .iv: iv]))
        let decryptedText = try cipherText.process(.init(.decrypt(.aes), [.key: key, .iv: iv]))
        XCTAssert(plainText == decryptedText)
    }
    
    func testStringProcessWithDigest() {
        let plainText = "I am fine"
        XCTAssertEqual(try plainText.process(.init(.digest(.md5))), "75dc9bbfa6b55441d6ea91dcb2e6e900")
        XCTAssertEqual(try plainText.process(.init(.digest(.sha1))), "a4b8d1d7b17bf814694770e6deec44b07ded3c98")
        XCTAssertEqual(try plainText.process(.init(.digest(.sha256))), "cf39f63b0188d40bb46686d2c0d092d9367650710ec5a869b41e5b1448c510f4")
    }
    
    func testStringProcessWithHMAC() {
        let plainText = "I am fine"
        let key = "11111111111111111111"
        XCTAssertEqual(try plainText.process(.init(.hmac(.sha1), [.key: key])), "f602de1d96b881613a7fed43b6fa6ec0bbb1857b")
    }
    
    func testChangeEncoding() throws {
        let text = "Hello world"
        let text1 = try text.process(.init(.changeEncoding, [.fromEncoding: Encoding.utf8, .toEncoding: Encoding.base64]))
        let text2 = try text1.process(.init(.changeEncoding, [.fromEncoding: Encoding.base64, .toEncoding:Encoding.utf8]))
        XCTAssert(text == text2)
    }
    
}
