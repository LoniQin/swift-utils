//
//  MD5.swift
//  
//
//  Created by Lonnie on 2021/1/6.
//

import Foundation

fileprivate func ROTLEFT(_ a: UInt32, _ b: UInt32) -> UInt32 {
    ((a << b) | (a >> (32 - b)))
}

fileprivate func F(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
    (x & y) | (~x & z)
}

fileprivate func G(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
    (x & z) | (y & ~z)
}

fileprivate func H(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
    x ^ y ^ z
}

fileprivate func I(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
    y ^ (x | ~z)
}

fileprivate func sum(_ items: UInt32...) -> UInt32 {
    var total: UInt32 = 0
    for item in items {
        total = total.addingReportingOverflow(item).partialValue
    }
    return total
}

fileprivate func FF(_ a: inout UInt32, _ b: UInt32, _ c: UInt32, _ d: UInt32, _ m: UInt32, _ s: UInt32, _ t: UInt32) {
    a = sum(a, F(b, c, d), m, t)
    a = sum(b, ROTLEFT(a, s))
}

fileprivate func GG(_ a: inout UInt32, _ b: UInt32, _ c: UInt32, _ d: UInt32, _ m: UInt32, _ s: UInt32, _ t: UInt32) {
    a = sum(a, G(b, c, d), m, t)
    a = sum(b, ROTLEFT(a, s))
}

fileprivate func HH(_ a: inout UInt32, _ b: UInt32, _ c: UInt32, _ d: UInt32, _ m: UInt32, _ s: UInt32, _ t: UInt32) {
    a = sum(a, H(b, c, d), m, t)
    a = sum(b, ROTLEFT(a, s))
}

fileprivate func II(_ a: inout UInt32, _ b: UInt32, _ c: UInt32, _ d: UInt32, _ m: UInt32, _ s: UInt32, _ t: UInt32) {
    a = sum(a, I(b, c, d), m, t)
    a = sum(b, ROTLEFT(a, s))
}

struct MD5 {
    
    struct Context {
        
        var data: [UInt8]
        
        var dataLength: Int
        
        var bitLength: Int
        
        var state: [UInt32]
        
        mutating func transform() {
            var m = [UInt32](repeating: 0, count: 16)
            var i = 0, j = 0
            while i < 16 {
                m[i] = UInt32(data[j]) + (UInt32(data[j + 1]) << 8) + (UInt32(data[j + 2]) << 16) + (UInt32(data[j + 3]) << 24)
                i += 1
                j += 4
            }
            var a = state[0], b = state[1], c = state[2], d = state[3]

            FF(&a,b,c,d,m[0],  7,0xd76aa478)
            FF(&d,a,b,c,m[1], 12,0xe8c7b756)
            FF(&c,d,a,b,m[2], 17,0x242070db)
            FF(&b,c,d,a,m[3], 22,0xc1bdceee)
            FF(&a,b,c,d,m[4],  7,0xf57c0faf)
            FF(&d,a,b,c,m[5], 12,0x4787c62a)
            FF(&c,d,a,b,m[6], 17,0xa8304613)
            FF(&b,c,d,a,m[7], 22,0xfd469501)
            FF(&a,b,c,d,m[8],  7,0x698098d8)
            FF(&d,a,b,c,m[9], 12,0x8b44f7af)
            FF(&c,d,a,b,m[10],17,0xffff5bb1)
            FF(&b,c,d,a,m[11],22,0x895cd7be)
            FF(&a,b,c,d,m[12], 7,0x6b901122)
            FF(&d,a,b,c,m[13],12,0xfd987193)
            FF(&c,d,a,b,m[14],17,0xa679438e)
            FF(&b,c,d,a,m[15],22,0x49b40821)

            GG(&a,b,c,d,m[1],  5,0xf61e2562)
            GG(&d,a,b,c,m[6],  9,0xc040b340)
            GG(&c,d,a,b,m[11],14,0x265e5a51)
            GG(&b,c,d,a,m[0], 20,0xe9b6c7aa)
            GG(&a,b,c,d,m[5],  5,0xd62f105d)
            GG(&d,a,b,c,m[10], 9,0x02441453)
            GG(&c,d,a,b,m[15],14,0xd8a1e681)
            GG(&b,c,d,a,m[4], 20,0xe7d3fbc8)
            GG(&a,b,c,d,m[9],  5,0x21e1cde6)
            GG(&d,a,b,c,m[14], 9,0xc33707d6)
            GG(&c,d,a,b,m[3], 14,0xf4d50d87)
            GG(&b,c,d,a,m[8], 20,0x455a14ed)
            GG(&a,b,c,d,m[13], 5,0xa9e3e905)
            GG(&d,a,b,c,m[2],  9,0xfcefa3f8)
            GG(&c,d,a,b,m[7], 14,0x676f02d9)
            GG(&b,c,d,a,m[12],20,0x8d2a4c8a)

            HH(&a,b,c,d,m[5],  4,0xfffa3942)
            HH(&d,a,b,c,m[8], 11,0x8771f681)
            HH(&c,d,a,b,m[11],16,0x6d9d6122)
            HH(&b,c,d,a,m[14],23,0xfde5380c)
            HH(&a,b,c,d,m[1],  4,0xa4beea44)
            HH(&d,a,b,c,m[4], 11,0x4bdecfa9)
            HH(&c,d,a,b,m[7], 16,0xf6bb4b60)
            HH(&b,c,d,a,m[10],23,0xbebfbc70)
            HH(&a,b,c,d,m[13], 4,0x289b7ec6)
            HH(&d,a,b,c,m[0], 11,0xeaa127fa)
            HH(&c,d,a,b,m[3], 16,0xd4ef3085)
            HH(&b,c,d,a,m[6], 23,0x04881d05)
            HH(&a,b,c,d,m[9],  4,0xd9d4d039)
            HH(&d,a,b,c,m[12],11,0xe6db99e5)
            HH(&c,d,a,b,m[15],16,0x1fa27cf8)
            HH(&b,c,d,a,m[2], 23,0xc4ac5665)

            II(&a,b,c,d,m[0],  6,0xf4292244)
            II(&d,a,b,c,m[7], 10,0x432aff97)
            II(&c,d,a,b,m[14],15,0xab9423a7)
            II(&b,c,d,a,m[5], 21,0xfc93a039)
            II(&a,b,c,d,m[12], 6,0x655b59c3)
            II(&d,a,b,c,m[3], 10,0x8f0ccc92)
            II(&c,d,a,b,m[10],15,0xffeff47d)
            II(&b,c,d,a,m[1], 21,0x85845dd1)
            II(&a,b,c,d,m[8],  6,0x6fa87e4f)
            II(&d,a,b,c,m[15],10,0xfe2ce6e0)
            II(&c,d,a,b,m[6], 15,0xa3014314)
            II(&b,c,d,a,m[13],21,0x4e0811a1)
            II(&a,b,c,d,m[4],  6,0xf7537e82)
            II(&d,a,b,c,m[11],10,0xbd3af235)
            II(&c,d,a,b,m[2], 15,0x2ad7d2bb)
            II(&b,c,d,a,m[9], 21,0xeb86d391)
            state[0] = sum(state[0], a)
            state[1] = sum(state[1], b)
            state[2] = sum(state[2], c)
            state[3] = sum(state[3], d)
        }
        
    }
    
    static let blockSize = 16
    
    private var context: Context
    
    private var buffer: [UInt8]
    
    public init() {
        self.context = .init(
            data: Array(repeating: 0, count: 64),
            dataLength: 0,
            bitLength: 0,
            state: [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476]
        )
        self.buffer = [UInt8](repeating: 0, count: Self.blockSize)
    }
 
    public mutating func update(_ data: Data) {
        for i in 0..<data.count {
            context.data[context.dataLength] = data[i]
            context.dataLength += 1
            if context.dataLength == context.data.count {
                context.transform()
                context.bitLength += 512
                context.dataLength = 0
            }
        }
    }
    
    public mutating func final() -> Data {
        var i = context.dataLength
        if context.dataLength < 56 {
            context.data[i] = 0x80
            i += 1
            while i < 56 {
                context.data[i] = 0
                i += 1
            }
        } else if context.dataLength >= 56 {
            context.data[i] = 0x80
            i += 1
            while i < 64 {
                context.data[i] = 0
                i += 1
            }
            context.transform()
            memset(&context.data, 0, 56)
        }
        context.bitLength += context.dataLength * 8
        for i in 0..<8 {
            context.data[56 + i] = UInt8((context.bitLength >> (8 * i)) & 0xff)
        }
        context.transform()
        for i in 0..<4 {
            buffer[i]      = UInt8((context.state[0] >> (UInt32(i) * 8)) & 0xff)
            buffer[i + 4]  = UInt8((context.state[1] >> (UInt32(i) * 8)) & 0xff)
            buffer[i + 8]  = UInt8((context.state[2] >> (UInt32(i) * 8)) & 0xff)
            buffer[i + 12] = UInt8((context.state[3] >> (UInt32(i) * 8)) & 0xff)
        }
        return Data(buffer)
    }
    
}
