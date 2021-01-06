//
//  MD5.swift
//  
//
//  Created by Lonnie on 2021/1/6.
//

import Foundation


fileprivate extension UInt32 {
    mutating func addSafely(_ b: UInt32) {
        self = addingReportingOverflow(b).partialValue
    }
}

public struct MD5 {
    
    public static let blockSize = 16
    public init() {

    }
 
    public mutating func update(_ d: Data) {
        for i in 0..<d.count {
            self.data[dataLength] = d[i]
            dataLength += 1
            if dataLength == data.count {
                transform()
                bitLength += 512
                dataLength = 0
            }
        }
    }
    
    public mutating func finalize() -> Data {
        var buffer = [UInt8](repeating: 0, count: Self.blockSize)
        var i = dataLength
        data[i] = 0x80
        i += 1
        if dataLength < 56 {
            while i < 56 {
                data[i] = 0
                i += 1
            }
        } else if dataLength >= 56 {
            while i < 64 {
                data[i] = 0
                i += 1
            }
            transform()
            memset(&data, 0, 56)
        }
        bitLength += dataLength * 8
        for i in 0..<8 {
            data[56 + i] = UInt8(truncatingIfNeeded: bitLength >> (8 * i))
        }
        transform()
        for i in 0..<4 {
            let shift = UInt32(8 * i)
            for j in 0..<4 {
                buffer[i + 4 * j] = UInt8(truncatingIfNeeded: state[j] >> shift)
            }
        }
        return Data(buffer)
    }
    
    private mutating func transform() {
        var m = [UInt32](repeating: 0, count: Self.blockSize)
        var j = 0
        for i in 0..<Self.blockSize {
            m[i] = UInt32(data[j]) + (UInt32(data[j + 1]) << 8) + (UInt32(data[j + 2]) << 16) + (UInt32(data[j + 3]) << 24)
            j += 4
        }
        var temp = state
        
        func ROTLEFT(_ a: UInt32, _ b: UInt32) -> UInt32 {
            ((a << b) | (a >> (32 - b)))
        }

        func F(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
            (x & y) | (~x & z)
        }

        func G(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
            (x & z) | (y & ~z)
        }

        func H(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
            x ^ y ^ z
        }

        func I(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
            y ^ (x | ~z)
        }
        
        let functions = [F, G, H, I]
        var value: UInt32 = 0
        for i in 0..<functions.count {
            for item in Self.rounds[i] {
                temp[item.0].addSafely(functions[i](temp[item.1], temp[item.2], temp[item.3]))
                temp[item.0].addSafely(m[item.4])
                temp[item.0].addSafely(item.6)
                value = temp[item.1]
                value.addSafely(ROTLEFT(temp[item.0], item.5))
                temp[item.0] = value
            }
        }
        for i in 0..<state.count {
            state[i].addSafely(temp[i])
        }
    }
    
    private var data: [UInt8] = .init(repeating: 0, count: 64)
    
    private var dataLength = 0
    
    private var bitLength = 0
    
    private var state: [UInt32] = [0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476]
    
    private static let rounds: [[(Int, Int, Int, Int, Int, UInt32, UInt32)]] = [
        [
            (0, 1, 2, 3, 0,  7, 0xd76aa478),
            (3, 0, 1, 2, 1, 12, 0xe8c7b756),
            (2, 3, 0, 1, 2, 17, 0x242070db),
            (1, 2, 3, 0, 3, 22, 0xc1bdceee),
            (0, 1, 2, 3, 4,  7, 0xf57c0faf),
            (3, 0, 1, 2, 5, 12, 0x4787c62a),
            (2, 3, 0, 1, 6, 17, 0xa8304613),
            (1, 2, 3, 0, 7, 22, 0xfd469501),
            (0, 1, 2, 3, 8,  7, 0x698098d8),
            (3, 0, 1, 2, 9, 12, 0x8b44f7af),
            (2, 3, 0, 1, 10, 17, 0xffff5bb1),
            (1, 2, 3, 0, 11, 22, 0x895cd7be),
            (0, 1, 2, 3, 12, 7, 0x6b901122),
            (3, 0, 1, 2, 13, 12, 0xfd987193),
            (2, 3, 0, 1, 14, 17, 0xa679438e),
            (1, 2, 3, 0, 15, 22, 0x49b40821)
        ],
        [
            (0, 1, 2, 3, 1,  5,0xf61e2562),
            (3, 0, 1, 2, 6,  9,0xc040b340),
            (2, 3, 0, 1, 11,14,0x265e5a51),
            (1, 2, 3, 0, 0, 20,0xe9b6c7aa),
            (0, 1, 2, 3, 5,  5,0xd62f105d),
            (3, 0, 1, 2, 10, 9,0x02441453),
            (2, 3, 0, 1, 15,14,0xd8a1e681),
            (1, 2, 3, 0, 4, 20,0xe7d3fbc8),
            (0, 1, 2, 3, 9,  5,0x21e1cde6),
            (3, 0, 1, 2, 14, 9,0xc33707d6),
            (2, 3, 0, 1, 3, 14,0xf4d50d87),
            (1, 2, 3, 0, 8, 20,0x455a14ed),
            (0, 1, 2, 3, 13, 5,0xa9e3e905),
            (3, 0, 1, 2, 2,  9,0xfcefa3f8),
            (2, 3, 0, 1, 7, 14,0x676f02d9),
            (1, 2, 3, 0, 12,20,0x8d2a4c8a)
        ],
        [
            (0, 1, 2, 3, 5,  4,0xfffa3942),
            (3, 0, 1, 2, 8, 11,0x8771f681),
            (2, 3, 0, 1, 11,16,0x6d9d6122),
            (1, 2, 3, 0, 14,23,0xfde5380c),
            (0, 1, 2, 3, 1,  4,0xa4beea44),
            (3, 0, 1, 2, 4, 11,0x4bdecfa9),
            (2, 3, 0, 1, 7, 16,0xf6bb4b60),
            (1, 2, 3, 0, 10,23,0xbebfbc70),
            (0, 1, 2, 3, 13, 4,0x289b7ec6),
            (3, 0, 1, 2, 0, 11,0xeaa127fa),
            (2, 3, 0, 1, 3, 16,0xd4ef3085),
            (1, 2, 3, 0, 6, 23,0x04881d05),
            (0, 1, 2, 3, 9,  4,0xd9d4d039),
            (3, 0, 1, 2, 12,11,0xe6db99e5),
            (2, 3, 0, 1, 15,16,0x1fa27cf8),
            (1, 2, 3, 0, 2, 23,0xc4ac5665)
        ],
        [
            (0, 1, 2, 3, 0,  6,0xf4292244),
            (3, 0, 1, 2, 7, 10,0x432aff97),
            (2, 3, 0, 1, 14,15,0xab9423a7),
            (1, 2, 3, 0, 5, 21,0xfc93a039),
            (0, 1, 2, 3, 12, 6,0x655b59c3),
            (3, 0, 1, 2, 3, 10,0x8f0ccc92),
            (2, 3, 0, 1, 10,15,0xffeff47d),
            (1, 2, 3, 0, 1, 21,0x85845dd1),
            (0, 1, 2, 3, 8,  6,0x6fa87e4f),
            (3, 0, 1, 2, 15,10,0xfe2ce6e0),
            (2, 3, 0, 1, 6, 15,0xa3014314),
            (1, 2, 3, 0, 13,21,0x4e0811a1),
            (0, 1, 2, 3, 4,  6,0xf7537e82),
            (3, 0, 1, 2, 11,10,0xbd3af235),
            (2, 3, 0, 1, 2, 15,0x2ad7d2bb),
            (1, 2, 3, 0, 9, 21,0xeb86d391)
        ],
    ]

}
