//
//  NSLock.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation

public extension NSLock {
    
    func tryLock<T>(_ time: TimeInterval = .greatestFiniteMagnitude, _ block: () throws -> T) throws -> T {
        let succeeded = self.lock(before: .init(timeIntervalSinceNow: time))
        defer {
            if succeeded { unlock() }
        }
        return try block()
    }
    
}
