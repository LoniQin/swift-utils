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

public protocol Logging {
    
    func log(message: Any..., level: Level, location: CodeLocation) throws
    
}

public extension Logging {
    
    @discardableResult
    func measure(name: String = #function, description: String = "", executeCount: Int = 1, printLog: Bool = true, _ block: () throws -> Void, location: CodeLocation = CodeLocation()) throws -> TimeInterval {
        let date = Date()
        for _ in 0..<executeCount {
            try block()
        }
        let time = Date().timeIntervalSince(date)
        if printLog {
            do {
                let value = [name, description].filter{ !$0.isEmpty }.joined(separator: " - ")
                try log(message: "\(value): \(time)s", level: .verbose, location: location)
            } catch {
                return time
            }
        }
        return time
    }

}
