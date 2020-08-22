//
//  DispatchQueue.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation
public extension DispatchQueue {
    
    static func sync<T>(
        on: DispatchQueue = .main,
        block: () throws -> T) throws -> T {
        if Thread.isMainThread {
            return try block()
        } else {
            return try DispatchQueue.main.sync(execute: block)
        }
    }
}
