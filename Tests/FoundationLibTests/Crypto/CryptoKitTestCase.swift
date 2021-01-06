//
//  CryptoKitTestCase.swift
//  
//
//  Created by Lonnie on 2021/1/5.
//
#if canImport(CryptoKit)
import CryptoKit
import CommonCrypto
#endif
import Foundation
import XCTest

final class CryptoKitTestCase: XCTestCase {
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
        let sharedSecret = try ephemeralKey.sharedSecretFromKeyAgreement(
            with: receiverEncryptionPublicKey
        )
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
    
    func testHash() {
        let data = "Hello world".data(using: .utf8)!
        var sha256 = SHA256()
        sha256.update(data: data)
        print(sha256.finalize())
    }
    
    func testHMAC() {
        let data = "Hello world".data(using: .utf8)!
        let key = SymmetricKey(data: Array(0..<32))
        // 生成数据验证码
        let authenticateCode = HMAC<SHA256>.authenticationCode(for: data, using: key)
        print(authenticateCode)
        // HMAC with SHA256: 8d02cc6dde5f1711bef21a1ed4b2d52f0c39daa8cef255bccae53ca24ef2f180
        let authenticateCodeData = Data(authenticateCode)
        // 验证数据
        let isValid = HMAC<SHA256>.isValidAuthenticationCode(authenticateCodeData, authenticating: data, using: key)
        print(isValid)
        // true
    }
    
    func testEncryption() throws {
        let data = "Hello world".data(using: .utf8)!
        let key = SymmetricKey(data: Array(0..<32))
        let encrypted = try AES.GCM.seal(data, using: key).combined!
        let box = try AES.GCM.SealedBox(combined: encrypted)
        let decrypted = try AES.GCM.open(box, using: key)
        print(String(data: decrypted, encoding: .utf8)!)
    }
    
    func testKeyAgreement() {
        let salt = "Salt".data(using: .utf8)!
        // 为Alice生成密钥对
        let alicePrivateKey = P256.KeyAgreement.PrivateKey()
        let alicePublicKey = alicePrivateKey.publicKey
        // 为Bob生成密钥对
        let bobPrivateKey = P256.KeyAgreement.PrivateKey()
        let bobPublicKey = bobPrivateKey.publicKey
        // 使用Alice的私钥和Bob的公钥计算出Alice的对称密钥
        let aliceSharedSecret = try! alicePrivateKey.sharedSecretFromKeyAgreement(with: bobPublicKey)
        let aliceSymmetricKey = aliceSharedSecret.hkdfDerivedSymmetricKey(
            using: SHA256.self,
            salt: salt,
            sharedInfo: Data(),
            outputByteCount: 32
        )
        // 使用Bob的私钥和Alice的公钥计算出Bob的对称密钥
        let bobSharedSecret = try! bobPrivateKey.sharedSecretFromKeyAgreement(with: alicePublicKey)
        let bobSymmetricKey = bobSharedSecret.hkdfDerivedSymmetricKey(
            using: SHA256.self,
            salt: salt,
            sharedInfo: Data(),
            outputByteCount: 32
        )   
        // Alice和Bob拥有相同的对称密钥
        print(aliceSymmetricKey == bobSymmetricKey)
        // true
        
    }
    
    func testVerifySignature() {
        
        let data = "Hello world".data(using: .utf8)!
        // 生成密钥对
        let signingKey = Curve25519.Signing.PrivateKey()
        let signingPublicKey = signingKey.publicKey
        let signingPublicKeyData = signingPublicKey.rawRepresentation
        let initializedSigningPublicKey = try! Curve25519.Signing.PublicKey(rawRepresentation: signingPublicKeyData)
        // 使用私钥计算签名
        let signautre = try! signingKey.signature(for: data)
        // 使用公钥验证签名
        print(initializedSigningPublicKey.isValidSignature(signautre, for: data))
        // true
    }
    
    func testPublicKeyEncryption2() throws {
        
        enum DecryptionErrors: Error {
            case authenticationError
        }
        let salt = "Salt".data(using: .utf8)!

        func encrypt(_ data: Data, to theirEncryptionKey: Curve25519.KeyAgreement.PublicKey, signedBy ourSigningKey: Curve25519.Signing.PrivateKey) throws ->
            (ephemeralPublicKeyData: Data, ciphertext: Data, signature: Data) {
                // 创建随机密钥对
                let ephemeralKey = Curve25519.KeyAgreement.PrivateKey()
                let ephemeralPublicKey = ephemeralKey.publicKey.rawRepresentation
                
                // 计算对称密钥
                let sharedSecret = try ephemeralKey.sharedSecretFromKeyAgreement(
                    with: theirEncryptionKey
                )
                
                let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(
                    using: SHA256.self,
                    salt: salt,
                    sharedInfo: ephemeralPublicKey + theirEncryptionKey.rawRepresentation + ourSigningKey.publicKey.rawRepresentation,
                    outputByteCount: 32
                )
                // 生成秘文
                let ciphertext = try ChaChaPoly.seal(data, using: symmetricKey).combined
            
                // 计算签名
                let signature = try ourSigningKey.signature(for: ciphertext + ephemeralPublicKey + theirEncryptionKey.rawRepresentation)
                //返回随机生成的公钥、秘文及签名
                return (ephemeralPublicKey, ciphertext, signature)
        }

        func decrypt(_ sealedMessage: (ephemeralPublicKeyData: Data, ciphertext: Data, signature: Data),
                     using ourKeyEncryptionKey: Curve25519.KeyAgreement.PrivateKey,
                     from theirSigningKey: Curve25519.Signing.PublicKey) throws -> Data {
            // 验证签名
            let data = sealedMessage.ciphertext + sealedMessage.ephemeralPublicKeyData + ourKeyEncryptionKey.publicKey.rawRepresentation
            guard theirSigningKey.isValidSignature(sealedMessage.signature, for: data) else {
                throw DecryptionErrors.authenticationError
            }
            // 发送者公钥
            let ephemeralKey = try Curve25519.KeyAgreement.PublicKey(
                rawRepresentation: sealedMessage.ephemeralPublicKeyData
            )
            
            // 计算对称密钥
            let sharedSecret = try ourKeyEncryptionKey.sharedSecretFromKeyAgreement(
                with: ephemeralKey
            )
            
            let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(
                using: SHA256.self,
                salt: salt,
                sharedInfo: ephemeralKey.rawRepresentation + ourKeyEncryptionKey.publicKey.rawRepresentation +
                                                                        theirSigningKey.rawRepresentation,
                outputByteCount: 32
            )
            
            // 解密
            let sealedBox = try ChaChaPoly.SealedBox(combined: sealedMessage.ciphertext)
            
            return try ChaChaPoly.open(sealedBox, using: symmetricKey)
        }

        let data = "Hello world".data(using: .utf8)!
        // 创建发送者的签名密钥
        let senderSigningKey = Curve25519.Signing.PrivateKey()
        let senderSigningPublicKey = senderSigningKey.publicKey
        // 创建接收者的加密密钥
        let receiverEncryptionKey = Curve25519.KeyAgreement.PrivateKey()
        let receiverEncryptionPublicKey = receiverEncryptionKey.publicKey
        // 发送者利用接收者的公钥来加密数据，并使用发送者的私钥签名。
        let encrypted = try encrypt(data, to: receiverEncryptionPublicKey, signedBy: senderSigningKey)

        // 接受者使用私钥加密数据，并使用发送者的公钥签名。
        let decryptedMessage = try decrypt(encrypted, using: receiverEncryptionKey, from: senderSigningPublicKey)
        print("\(String(data: decryptedMessage, encoding: .utf8)!)")
        // Hello world
        
    }
    #endif
}
