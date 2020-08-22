//
//  NSLock+Extension.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation
public extension NSLock {
    
    func tryLock<T>(_ block: () throws -> T) throws -> T {
        let succeeded = self.try()
        defer {
            if succeeded { unlock() }
        }
        return try block()
    }
    
}
