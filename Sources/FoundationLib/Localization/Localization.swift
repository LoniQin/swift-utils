//
//  Localization.swift
//  
//
//  Created by lonnie on 2020/8/23.
//

import Foundation

public struct Localization {
    
    public var tableName: String
    
    public var bundle: Bundle
    
    public init(tableName: String, bundle: Bundle = .main) {
        self.tableName = tableName
        self.bundle = bundle
    }
    
    public func string(for key: CustomStringConvertible) -> String {
        return NSLocalizedString(
            key.description,
            tableName: tableName,
            bundle: bundle,
            comment: ""
        )
    }
    
}
