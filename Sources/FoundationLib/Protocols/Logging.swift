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
    
    func log(_ level: Level, message: Any...)
    
}
