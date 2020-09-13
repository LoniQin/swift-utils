//
//  DebugLogger.swift
//  
//
//  Created by lonnie on 2020/9/13.
//

import Foundation
struct DebugLogger: Logging {
    
    func log(_ level: Level, _ messages: Any...) throws {
        debugPrint(level.rawValue.uppercased() + ":", messages)
    }
    
}
