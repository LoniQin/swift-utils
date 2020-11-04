//
//  Array.swift
//  
//
//  Created by lonnie on 2020/1/1.
//

import Foundation

public extension Array {
    
    @discardableResult
    func get<T>(_ index: Int) throws -> T {
        let value: Optional<T> = self.get(index)
        switch value {
        case .none:
            throw FoundationError.nilValue
        case .some(let item):
            return item
        }
    }
    
    @discardableResult
    func get<T: ExpressibleByNilLiteral>(_ index: Int) -> T {
        guard
            index < count,
            let value: T = self[index] as? T
        else {
            return nil
        }
        return value
    }
    
    init(@ArrayBuilder _ builder: () -> Self) {
        self = builder()
    }
    
    mutating func appending(_ items: Element...) -> Self {
        self.append(contentsOf: items)
        return self
    }
    
    mutating func removingLast(_ v: Int = 1) -> Self {
        self.removeLast(v)
        return self
    }
    
    @discardableResult
    mutating func safelyInsert(_ element: Element, at index: Int, succeed: inout Bool?) -> Self {
        if index < 0  || index > count {
            succeed = false
            return self
        }
        succeed = true
        if index == count {
            append(element)
            return self
        }
        var i = count
        append(self[count - 1])
        while i >= index {
            if i == index  {
                self[index] = element
            } else {
                self[i] = self[i - 1]
            }
            i -= 1
        }
        return self
    }
    
    @discardableResult
    mutating func safelyDelete(at index: Int, succeed: inout Bool?) -> Self {
        if index < 0  || index >= count {
            succeed = false
            return self
        }
        succeed = true
        for i in index..<count-1 {
            self[i] = self[i + 1]
        }
        self.removeLast()
        return self
    }
    
    @discardableResult
    mutating func reverse(at range: Range<Int>) -> Self {
        if range.lowerBound < 0 || range.upperBound > count || range.lowerBound >= range.upperBound { return self }
        var from = range.lowerBound
        var to = range.upperBound - 1
        while from < to {
            swapAt(from, to)
            from += 1
            to -= 1
        }
        return self
    }
    
    mutating func append(@ArrayBuilder _ builder: () -> Self) {
        self.append(contentsOf: builder())
    }
    
    init(count: Int, in elements: [Element]) {
        self.init()
        for _ in 0..<count {
            self.append(elements[Int.random(in: 0..<elements.count)])
        }
    }
    
}

public extension Array where Element: Equatable {
    
    func locate(_ element: Element) -> Int {
        for i in 0..<count {
            if self[i] == element {
                return i
            }
        }
        return -1
    }
    
}

public extension Array where Element: Comparable {
    
    @discardableResult
    mutating func remove(from: Element, to: Element) -> Self {
        var pointer = 0
        var i = 0
        while i < count  {
            if self[i] >= from && self[i] <= to {
                i += 1
            } else {
                self[pointer] = self[i]
                pointer += 1
                i += 1
            }
        }
        if count - pointer > 0 {
            self.removeLast(count - pointer)
        }
        return self
    }
}
