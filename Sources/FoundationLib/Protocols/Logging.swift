//
//  Logging.swift
//  
//
//  Created by lonnie on 2020/9/13.
//

import Foundation

public enum Level: String {
    
    case verbose
    
    case warning
    
    case error
    
}

protocol Logging {
    
    func log(_ level: Level, _ messages: Any...) throws
    
}

extension Logging {
    
    @discardableResult
    func measure(name: String = #function, executeCount: Int = 1, printLog: Bool = true, _ block: () -> Void) throws -> TimeInterval {
        let date = Date()
        for _ in 0..<executeCount {
            block()
        }
        let time = Date().timeIntervalSince(date)
        if printLog {
            do {
                try log(.verbose, "\(name): \(time)s")
            } catch {
                return time
            }
        }
        return time
    }

}
