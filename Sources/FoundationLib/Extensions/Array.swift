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
