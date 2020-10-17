//
//  StringConvertable.swift
//  
//
//  Created by lonnie on 2020/8/16.
//

import Foundation
public protocol StringConvertable {
    
    static func fromString(_ string: String) throws -> Self
    
    /// Convert to String instance
    func toString() -> String
    
}

extension String: StringConvertable {
    
    public static func fromString(_ string: String) throws -> Self {
        string
    }
    
    public func toString() -> String {
        self
    }
    
}
