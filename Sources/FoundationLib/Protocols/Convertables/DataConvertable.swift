//
//  DataConvertable.swift
//  
//
//  Created by lonnie on 2020/8/16.
//

import Foundation

public protocol DataConvertable {
    
    static func fromData(_ data: Data) throws -> Self
    
    func toData() throws -> Data
    
}

extension Data: DataConvertable {
    
    public static func fromData(_ data: Data) throws -> Data {
        return data
    }
    
    public func toData() throws -> Data {
        self
    }
    
}

extension String: DataConvertable {
    
    public static func fromData(_ data: Data) throws -> String {
        try data.string(.utf8)
    }
    
    
    public func toData() throws -> Data {
        try data(.utf8)
    }
    
}

extension Dictionary: DataConvertable where Key == String, Value: Any {
    
    public static func fromData(_ data: Data) throws -> Dictionary<Key, Value> {
        guard let value = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<Key, Value>  else {
            throw FoundationError.invalidCoding
        }
        return value
    }
    
    
    public func toData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
    
}
