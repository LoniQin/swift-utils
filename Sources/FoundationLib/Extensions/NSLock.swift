//
//  NSLock.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation

public extension NSLock {
    
    func tryLock<T>(_ time: TimeInterval = 0, _ block: () throws -> T) throws -> T {
        let succeeded = self.lock(before: time == 0 ? .distantFuture:  .init(timeIntervalSinceNow: time))
        defer {
            if succeeded { unlock() }
        }
        return try block()
    }
    
}
