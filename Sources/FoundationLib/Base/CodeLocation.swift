//
//  CodeLocation.swift
//  
//
//  Created by lonnie on 2020/10/10.
//

import Foundation
public struct CodeLocation {
    
    public var file: String
    
    public var line: Int
    
    public var column: Int
    
    public var function: String
    
    public init(file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        self.file = file
        self.line = line
        self.column = column
        self.function = function
    }
}
