//
//  DebugLogger.swift
//  
//
//  Created by lonnie on 2020/9/13.
//

import Foundation
public class DebugLogger: Logging {
    
    public let `default` = DebugLogger()
    
    public func log(_ level: Level, _ messages: Any...) throws {
        debugPrint(messages)
    }
    
}
