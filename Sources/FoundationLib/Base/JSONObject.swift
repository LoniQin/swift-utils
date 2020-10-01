//
//  JSONObject.swift
//  
//
//  Created by lonnie on 2020/9/20.
//
import Foundation
@dynamicCallable
@dynamicMemberLookup
public class JSONObject: DataConvertable {
    
    public var value = [String: Any]()
    
    public init(_ value: [String: Any] = [:]) {
        self.value = value
    }
    
    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) {
        for item in args {
            value[item.0] = item.1
        }
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
    
    public func get<T>(_ member: String) -> T? {
        value[member] as? T
    }
    
    public func toData() throws -> Data {
        try JSONSerialization.data(withJSONObject: value, options: .fragmentsAllowed)
    }
    
}
