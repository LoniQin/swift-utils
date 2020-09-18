//
//  ArrayBuilder.swift
//  
//
//  Created by lonnie on 2020/9/18.
//

import Foundation
@_functionBuilder struct ArrayBuilder {
    static func buildBlock<T>(_ items: T...) -> [T] {
        items
    }
}
public extension Array {
    
    init(@ArrayBuilder _ builder: () -> Self) {
        self = builder()
    }
    
    mutating func append(@ArrayBuilder _ builder: () -> Self) {
        self.append(contentsOf: builder())
    }
    
}
