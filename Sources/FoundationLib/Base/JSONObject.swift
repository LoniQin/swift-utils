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
            get(member)
        }
        set {
            value[member] = newValue
        }
    }
    
    public subscript(dynamicMember member: String) -> Int? {
        get {
            get(member)
        }
        set {
            value[member] = newValue
        }
    }
    
    public subscript(dynamicMember member: String) -> Double? {
        get {
            get(member)
        }
        set {
            value[member] = newValue
        }
    }
    
    public subscript(dynamicMember member: String) -> Float? {
        get {
            get(member)
        }
        set {
            value[member] = newValue
        }
    }
    
    public subscript(dynamicMember member: String) -> Any? {
        get {
            get(member)
        }
        set {
            value[member] = newValue
        }
    }
    
    func get<T>(_ member: String) -> T? {
        value[member] as? T
    }
    
    public func toData() throws -> Data {
        try JSONSerialization.data(withJSONObject: value, options: .fragmentsAllowed)
    }
    
}
