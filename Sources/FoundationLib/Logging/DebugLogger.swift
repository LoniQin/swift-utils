//
//  DebugLogger.swift
//  
//
//  Created by lonnie on 2020/9/13.
//

import Foundation
public struct DebugLogger: Logging {
    
    public static let `default` = DebugLogger()
    
    public func log(message: Any..., level: Level = .verbose, location: CodeLocation = CodeLocation(file: #file, line: #line, function: #function)) throws {
        let desc = "\(location.file) ~ \(location.function) ~ \(location.line): " + message.map { "\($0)" }.joined(separator: " ")
        debugPrint(desc)
    }
    
}
