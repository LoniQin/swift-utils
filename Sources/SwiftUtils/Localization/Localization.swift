//
//  Localization.swift
//  
//
//  Created by lonnie on 2020/8/23.
//

import Foundation
@dynamicMemberLookup
public struct Localization {

    public let tableName: String
    
    public let bundle: Bundle
    
    public init(tableName: String, bundle: Bundle = .main) {
        self.tableName = tableName
        self.bundle = bundle
    }
    
    public func string(for key: CustomStringConvertible) -> String {
        NSLocalizedString(
            key.description,
            tableName: tableName,
            bundle: bundle,
            comment: ""
        )
    }
    
    public subscript(dynamicMember member: String) -> String {
        string(for: member)
    }
    
}
