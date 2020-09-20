//
//  JSONObject.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation
@dynamicMemberLookup
public struct JSONObject: DataConvertable {
    
    public var value = [String: Any]()
    
    public init(_ value: [String: Any] = [:]) {
        self.value = value
    }
    
    public subscript(dynamicMember member: String) -> String? {
        get {
            value[member] as? String
        }
        set {
            value[member] = newValue
        }
    }
    
    public subscript(dynamicMember member: String) -> Int? {
        get {
            value[member] as? Int
        }
        set {
            value[member] = newValue
        }
    }
    
    public subscript(dynamicMember member: String) -> Double? {
        get {
            value[member] as? Double
        }
        set {
            value[member] = newValue
        }
    }
    
    public subscript(dynamicMember member: String) -> Float? {
        get {
            value[member] as? Float
        }
        set {
            value[member] = newValue
        }
    }
    
    public func toData() throws -> Data {
        try JSONSerialization.data(withJSONObject: value, options: .fragmentsAllowed)
    }
    
}
