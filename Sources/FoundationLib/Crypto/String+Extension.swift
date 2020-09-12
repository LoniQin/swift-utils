//
//  String+Extension.swift
//  
//
//  Created by lonnie on 2020/8/15.
//

import Foundation

public extension String {
    
    func data(_ encoding: FoundationLib.Encoding) throws -> Data {
        var d: Data?
        switch encoding {
        case .base64:
            d = Data(base64Encoded: self)
        case .ascii:
            d = data(using: .ascii)
        case .utf8:
            d = data(using: .utf8)
        case .hex:
            d = try Data(hex: self)
        }
        guard let value = d else { throw CryptoError.codingError }
        return value
    }
    
    func digest(_ algorithm: Digest) throws -> String {
        try algorithm.process(try data(.utf8)).string(.hex)
    }
    
    func process(_ options: ProcessOptions) throws -> String {
        var fromEncoding: FoundationLib.Encoding = .utf8
        var toEncoding: FoundationLib.Encoding = .hex
        switch options.method {
        case .encrypt:
            fromEncoding = options[.fromEncoding] ?? .utf8
            toEncoding = options[.toEncoding] ?? .base64
        case .decrypt:
            fromEncoding = options[.fromEncoding] ?? .base64
            toEncoding = options[.toEncoding] ?? .utf8
        case .digest, .hmac:
            fromEncoding = options[.fromEncoding] ?? .utf8
            toEncoding = options[.toEncoding] ?? .hex
        case .changeEncoding:
            if let from: FoundationLib.Encoding = options[.fromEncoding], let to: FoundationLib.Encoding = options[.toEncoding] {
                return try data(from).string(to)
            } else {
                throw CryptoError.invalidParams
            }
        }
        return try data(fromEncoding).process(options).string(toEncoding)
    }
    
}
