//
//  File.swift
//  
//
//  Created by lonnie on 2020/10/18.
//

import Foundation
public class BitArray {
    
    var items: [UInt64]
    
    public var range: Range<Int>
    
    public var capacity: Int
    
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
