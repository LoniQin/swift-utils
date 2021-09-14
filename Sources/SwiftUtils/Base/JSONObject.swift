//
//  JSONObject.swift
//  
//
//  Created by lonnie on 2020/9/20.
//
import Foundation
@dynamicCallable
open class JSONObject: NSObject, DataConvertable, DynamicMemberLookupable, DynamicNewable {

    public var params = [String: Any]()
    
    public required override init() {
        super.init()
        self.params = [:]
    }
    
    public convenience init(_ data: Data) throws {
        guard let params = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw FoundationError.nilValue
        }
    
        self.init(params)
    }
    
    required public init(_ params: [String: Any]) {
        self.params = params
    }
    
    public static func fromData(_ data: Data) throws -> Self {
        guard let params = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw FoundationError.nilValue
        }
        return Self(params)
    }
    
    public func toData() throws -> Data {
        try JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
    }
    
}
