//
//  DispatchQueue.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation

public extension DispatchQueue {
    
    static func sync<T>(
        onMain block: () throws -> T) throws -> T {
        Thread.isMainThread ? try block() : try DispatchQueue.main.sync(execute: block)
    }
    
    func after(_ delay: TimeInterval, block closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
}
