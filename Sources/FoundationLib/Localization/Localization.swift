//
//  Localization.swift
//  
//
//  Created by lonnie on 2020/8/23.
//

import Foundation

public struct Localization {
    
    public var tableName: String
    
    public init(tableName: String) {
        self.tableName = tableName
    }
    
    public func string(for key: CustomStringConvertible) -> String {
        return NSLocalizedString(key.description, tableName: tableName, comment: "")
    }
    
}
