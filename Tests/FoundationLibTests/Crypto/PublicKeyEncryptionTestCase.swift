//
//  PublicKeyEncryptionTestCase.swift
//  
//
//  Created by Lonnie on 2021/1/5.
//
#if canImport(CryptoKit)
import CryptoKit
#endif
import Foundation
import XCTest
@testable import FoundationLib

final class PublicKeyEncryptionTestCase: XCTestCase {
    #if canImport(CryptoKit)
    func testPublicKeyEncryption() throws {
        // Create a message to send
        let salt = try "salt".data(.utf8)
        let message = try "This is a secret message.".data(.utf8)
        // Sending's signing key
        let senderSigningKey = Curve25519.Signing.PrivateKey()
        let senderSigningPublicKey = senderSigningKey.publicKey
        
        // Receiver's encryption key
        let receiverEncryptionKey = Curve25519.KeyAgreement.PrivateKey()
        let receiverEncryptionPublicKey = receiverEncryptionKey.publicKey
        
        // Encrypt message
        let ephemeralKey = Curve25519.KeyAgreement.PrivateKey()
        let ephemeralPublicKey = ephemeralKey.publicKey.rawRepresentation
        let sharedSecret = try ephemeralKey.sharedSecretFromKeyAgreement(with: receiverEncryptionPublicKey)
        let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(
            using: SHA256.self,
            salt: salt,
            sharedInfo: ephemeralPublicKey + receiverEncryptionPublicKey.rawRepresentation + senderSigningKey.publicKey.rawRepresentation,
            outputByteCount: 32
        )
        let cipherText = try ChaChaPoly.seal(message, using: symmetricKey).combined
        let signature = try senderSigningKey.signature(
            for: cipherText + ephemeralPublicKey + receiverEncryptionPublicKey.rawRepresentation
        )
        // Decrypt message
        let data = cipherText + ephemeralPublicKey + receiverEncryptionKey.publicKey.rawRepresentation
        guard senderSigningPublicKey.isValidSignature(signature, for: data) else {
            XCTFail("Authentication error")
            return
        }
        let ephemeralKey2 = try Curve25519.KeyAgreement.PublicKey(rawRepresentation: ephemeralPublicKey)
        let sharedSecret2 = try receiverEncryptionKey.sharedSecretFromKeyAgreement(with: ephemeralKey2)
        let symmetricKey2 = sharedSecret2.hkdfDerivedSymmetricKey(
            using: SHA256.self,
            salt: salt,
            sharedInfo: ephemeralKey2.rawRepresentation + receiverEncryptionKey.publicKey.rawRepresentation + senderSigningPublicKey.rawRepresentation,
            outputByteCount: 32
        )
        let sealedBox = try ChaChaPoly.SealedBox(combined: cipherText)
        let result = try ChaChaPoly.open(sealedBox, using: symmetricKey2)
        try result.string(.utf8).assert.equal("This is a secret message.")
    }
    #endif
}
