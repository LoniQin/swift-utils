//
//  SHA1.swift
//  
//
//  Created by Lonnie on 2021/1/7.
//

import Foundation

fileprivate func ROTATE_LEFT(_ a: UInt32, _ b: UInt32) -> UInt32 {
    ((a << b) | (a >> (32 - b)))
}

public struct SHA1 {
    
    public static let blockSize = 20
    
    private var data: [UInt8] = .init(repeating: 0, count: 64)
    
    private var dataLength = 0
    
    private var bitLength = 0
    
    private var state: [UInt32] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xc3d2e1f0]
    
    public init() {

    }
 
    public mutating func update(_ d: Data) {
        for i in 0..<d.count {
            self.data[dataLength] = d[i]
            dataLength += 1
            if dataLength == 64 {
                transform()
                bitLength += 512
                dataLength = 0
            }
        }
    }
    
    public mutating func finalize() -> Data {
        
        var i = dataLength
        
        data[i] = 0x80
        i += 1
        if dataLength > 55 {
            while i < 64 {
                data[i] = 0
                i += 1
            }
            transform()
            memset(&data, 0, 56)
        } else {
            while i < 56 {
                data[i] = 0
                i += 1
            }
        }
        bitLength += dataLength * 8

        data[63] = UInt8(bitLength & 0xff)
        data[62] = UInt8((bitLength >> 8) & 0xff)
        data[61] = UInt8((bitLength >> 16) & 0xff)
        data[60] = UInt8((bitLength >> 24) & 0xff)
        data[59] = UInt8((bitLength >> 32) & 0xff)
        data[58] = UInt8((bitLength >> 40) & 0xff)
        data[57] = UInt8((bitLength >> 48) & 0xff)
        data[56] = UInt8((bitLength >> 56) & 0xff)
        transform()
        var hash = [UInt8](repeating: 0, count: Self.blockSize)
        for i in 0..<4 {
            let shift = UInt32(24 - i * 8)
            hash[i] = UInt8((state[0] >> shift) & 0xff)
            hash[i + 4] = UInt8((state[1] >> shift) & 0xff)
            hash[i + 8] = UInt8((state[2] >> shift) & 0xff)
            hash[i + 12] = UInt8((state[3] >> shift) & 0xff)
            hash[i + 16] = UInt8((state[4] >> shift) & 0xff)
        }
        return Data(hash)
    }
    
    private mutating func transform() {
        var m = [UInt32](repeating: 0, count: 80)
        for t in 0..<16 {
            m[t] = (UInt32(data[4 * t]) << 24)
            m[t] |= (UInt32(data[4 * t + 1]) << 16)
            m[t] |= (UInt32(data[4 * t + 2]) << 8)
            m[t] |= UInt32(data[4 * t + 3])
        }
        for t in 16..<80 {
            m[t] = ROTATE_LEFT(m[t - 3] ^ m[t - 8] ^ m[t - 14] ^ m[t - 16], 1)
        }
        var t: UInt32 = 0
        var f: UInt32 = 0
        var k: UInt32 = 0
        var a = state[0]
        var b = state[1]
        var c = state[2]
        var d = state[3]
        var e = state[4]
        for i in 0..<80 {
            switch i {
            case 0...19:
                f = (b & c) | ((~b) & d)
                k = 0x5a827999
            case 20...39:
                f = b ^ c ^ d
                k = 0x6ed9eba1
            case 40...59:
                f = (b & c) | (b & d) | (c & d)
                k = 0x8f1bbcdc
            default:
                f = b ^ c ^ d
                k = 0xca62c1d6
            }
            t = ROTATE_LEFT(a, 5) &+ f &+ e &+ k &+ m[i]
            e = d
            d = c
            c = ROTATE_LEFT(b, 30)
            b = a
            a = t
        }
        state[0] &+= a
        state[1] &+= b
        state[2] &+= c
        state[3] &+= d
        state[4] &+= e
        
    }

}

