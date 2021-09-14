//
//  SHA1.swift
//
//
//  Created by Lonnie on 2021/1/7.
//

import Foundation

fileprivate func ROTATE_LEFT(_ a: UInt32, _ b: UInt32) -> UInt32 { ((a << b) | (a >> (32 - b))) }

fileprivate func F1(_ b: UInt32, _ c: UInt32, _ d: UInt32) -> UInt32 { (b & c) | ((~b) & d) }

fileprivate func F2(_ b: UInt32, _ c: UInt32, _ d: UInt32) -> UInt32 { b ^ c ^ d }

fileprivate func F3(_ b: UInt32, _ c: UInt32, _ d: UInt32) -> UInt32 { (b & c) | (b & d) | (c & d) }

public struct SHA1 {
    
    public static let blockSize = 20
    
    public init() {}
    
    private var data = [UInt8](repeating: 0, count: 64)
    
    private var dataLength = 0
    
    private var bitLength = 0
    
    private var state: [UInt32] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xc3d2e1f0]
    
    private static let rounds = [
        (0...19, UInt32(0x5a827999), F1),
        (20...39, UInt32(0x6ed9eba1), F2),
        (40...59, UInt32(0x8f1bbcdc), F3),
        (60...79, UInt32(0xca62c1d6), F2)
    ]

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
        data[dataLength] = 0x80
        data.resetBytes(in: (dataLength + 1)..<(56 + (dataLength >= 56 ? 8 : 0)))
        if dataLength >= 56 {
            transform()
            data.resetBytes(in: 0..<56)
        }
        bitLength += dataLength * 8
        for i in 0..<8 {
            data[63 - i] = UInt8(truncatingIfNeeded: bitLength >> (8 * i))
        }
        transform()
        var hash = [UInt8](repeating: 0, count: Self.blockSize)
        for i in 0..<4 {
            let shift = UInt32(24 - i * 8)
            for j in 0..<state.count {
                hash[i + 4 * j] = UInt8(truncatingIfNeeded: state[j] >> shift)
            }
        }
        return Data(hash)
    }
    
    private mutating func transform() {
        var m = [UInt32](repeating: 0, count: 80)
        for t in 0..<16 {
            m[t] = (UInt32(data[4 * t]) << 24) + (UInt32(data[4 * t + 1]) << 16) + (UInt32(data[4 * t + 2]) << 8) + UInt32(data[4 * t + 3])
        }
        for t in 16..<80 {
            m[t] = ROTATE_LEFT(m[t - 3] ^ m[t - 8] ^ m[t - 14] ^ m[t - 16], 1)
        }
        var t: UInt32 = 0
        var temp = state
        for round in Self.rounds {
            for i in round.0 {
                t = ROTATE_LEFT(temp[0], 5) &+ round.2(temp[1], temp[2], temp[3]) &+ temp[4] &+ round.1 &+ m[i]
                temp[4] = temp[3]
                temp[3] = temp[2]
                temp[2] = ROTATE_LEFT(temp[1], 30)
                temp[1] = temp[0]
                temp[0] = t
            }
        }
        for i in 0..<state.count {
            state[i] &+= temp[i]
        }
    }
}

