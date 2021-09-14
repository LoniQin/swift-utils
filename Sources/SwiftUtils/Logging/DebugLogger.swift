//
//  DebugLogger.swift
//  
//
//  Created by lonnie on 2020/9/13.
//

import Foundation
public struct DebugLogger: Logging {
    
    public static let `default` = DebugLogger()
    
    public func log(message: Any..., level: Level = .verbose,
                    location: CodeLocation? = nil) throws {
        var desc = ""
        if let location = location {
            desc = "\(location.file) ~ \(location.function) ~ \(location.line): "
        }
        desc += message.map { "\($0)" }.joined(separator: " ")
        debugPrint(desc)
    }
    
}
