//
//  BitArray.swift
//  
//
//  Created by lonnie on 2020/10/18.
//

import Foundation
public class BitArray: Sequence {
    
    public struct Iterater: IteratorProtocol {
        
        public var bitArray: BitArray
        
        var start: Int
        
        public init(_ bitArray: BitArray) {
            self.bitArray = bitArray
            start = bitArray.range.lowerBound
        }
        
        mutating public func next() -> Int? {
            while start < bitArray.range.upperBound {
                if bitArray.contains(start) {
                    let value = start
                    start += 1
                    return value
                }
                start += 1
            }
            return nil
        }
    }
    
    public func makeIterator() -> Iterater {
        return Iterater(self)
    }
    
    var items: [UInt64]
    
    public let range: Range<Int>
    
    public let capacity: Int
    
    public init(_ range: Range<Int>) {
        self.range = range
        capacity = range.upperBound - range.lowerBound
        self.items = .init(repeating: 0, count: capacity / 64 + 1)
    }
    
    public func add(_ key: Int) throws {
        if !range.contains(key) { throw FoundationError.outOfBounds }
        let delta = key - range.lowerBound
        items[delta >> 6] |= 1 << (delta & 0b111111)
    }
    
    public func remove(_ key: Int) throws {
        if !range.contains(key) { throw FoundationError.outOfBounds }
        let delta = key - range.lowerBound
        items[delta >> 6] &= ~(1 << (delta & 0b111111))
    }
    
    public func contains(_ key: Int) -> Bool {
        if !range.contains(key) { return false }
        let delta = key - range.lowerBound
        return (items[delta >> 6]) & (1 << (delta & 0b111111)) > 0
    }
    
}
