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
    
    mutating func append(@ArrayBuilder _ builder: () -> Self) {
        self.append(contentsOf: builder())
    }
    
}
