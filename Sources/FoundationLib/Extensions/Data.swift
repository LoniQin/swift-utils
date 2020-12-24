//
//  Data.swift
//  
//
//  Created by lonnie on 2020/9/12.
//

import Foundation

fileprivate let charA = UInt8(UnicodeScalar("a").value)
fileprivate let char0 = UInt8(UnicodeScalar("0").value)

private func itoh(_ value: UInt8) -> UInt8 {
    (value > 9) ? (charA + value - 10) : (char0 + value)
}

private func htoi(_ value: UInt8) throws -> UInt8 {
    switch value {
    case char0...char0 + 9:
        return value - char0
    case charA...charA + 5:
        return value - charA + 10
    default:
        throw CryptoError.codingError
    }
}

public extension Data {
    
    init(hex: String) throws {
        self.init()

        if hex.count & 1 != 0 || hex.count == 0 {
            throw CryptoError.codingError
        }

        let stringBytes: [UInt8] = Array(try hex.data(.utf8))

        for i in 0...((hex.count / 2) - 1) {
            let char1 = stringBytes[2 * i]
            let char2 = stringBytes[2 * i + 1]
            try self.append(htoi(char1) << 4 + htoi(char2))
        }
    }
    
    var hex: String {
        let hexLen = self.count * 2
        let ptr = UnsafeMutablePointer<UInt8>.allocate(capacity: hexLen)
        var offset = 0
        
        self.regions.forEach { (_) in
            for i in self {
                ptr[Int(offset * 2)] = itoh((i >> 4) & 0xF)
                ptr[Int(offset * 2 + 1)] = itoh(i & 0xF)
                offset += 1
            }
        }
        
        return String(bytesNoCopy: ptr, length: hexLen, encoding: .utf8, freeWhenDone: true)!
    }
    
    func string(_ encoding: Encoding) throws -> String {
        var value: String?
        switch encoding {
        case .ascii:
            value = String(data: self, encoding: .ascii)
        case .utf8:
            value = String(data: self, encoding: .utf8)
        case .hex:
            value = hex
        case .base64:
            value = self.base64EncodedString()
        }
        guard let item = value else {
            throw CryptoError.codingError
        }
        return item
    }
    
    init(random count: Int) {
        var items = [UInt8](repeating: 0, count: count)
        arc4random_buf(&items, items.count)
        self.init(items)
    }
    
}
