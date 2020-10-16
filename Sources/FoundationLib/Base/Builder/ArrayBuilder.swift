//
//  ArrayBuilder.swift
//  
//
//  Created by lonnie on 2020/9/18.
//

import Foundation
@_functionBuilder
public struct ArrayBuilder {
    
    public static func buildBlock<T>(_ item: T) -> [T] {
        return [item]
    }
    
    public static func buildBlock<T>(_ items: T...) -> [T] {
        items
    }
    
}
