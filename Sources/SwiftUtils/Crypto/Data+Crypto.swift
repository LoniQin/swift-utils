//
//  Data+Crypto.swift
//  
//
//  Created by lonnie on 2020/8/14.
//  Copyright © 2020 lonnie. All rights reserved.
//

import Foundation

public extension Data {
    
    func process(_ options: ProcessOptions) throws -> Data {
        switch options.method {
        case .encrypt(let algorithm):
            return try symmetryCrypt(algorithm, .encrypt, options)
        case .decrypt(let algorithm):
            return try symmetryCrypt(algorithm, .decrypt, options)
        case .digest(let digest):
            return digest.process(self)
        case .hmac(let algorithm):
            guard let key: DataConvertable = options[.key]  else { throw CryptoError.invalidKey }
            return try HMAC(algorithm, key: key.toData()).process(self)
        case .changeEncoding:
            return self
        case .none:
            return self
        }
    }
    
    func symmetryCrypt(_ algorithm: SymmetricCipher.Algorithm, _ operation: SymmetricCipher.Operation, _ options: ProcessOptions) throws -> Data {
        let mode: SymmetricCipher.Mode = options[.mode] ?? .cbc
        let padding: SymmetricCipher.Padding = options[.padding] ?? .pkcs7
        guard let key: DataConvertable = options[.key] else { throw CryptoError.invalidKey }
        var iv: DataConvertable = Data()
        if let _iv: DataConvertable = options[.iv] {
            iv = _iv
        }
        let cipher = try SymmetricCipher(
            algorithm,
            key: key.toData(),
            iv: iv.toData(),
            padding: padding,
            mode: mode
        )
        return try cipher.process(operation, self)
    }

}
