//
//  DebugLogger.swift
//  
//
//  Created by lonnie on 2020/9/13.
//

import Foundation
public struct DebugLogger: Logging {
    
    public static let `default` = DebugLogger()
    
    public func log(_ level: Level = .verbose, _ messages: Any...) throws {
        debugPrint(messages.map { "\($0)" }.joined(separator: " "))
    }
    
}
