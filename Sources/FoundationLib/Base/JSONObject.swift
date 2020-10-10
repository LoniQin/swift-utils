//
//  JSONObject.swift
//  
//
//  Created by lonnie on 2020/9/20.
//
import Foundation
@dynamicCallable
open class JSONObject: NSObject, DataConvertable, DynamicMemberLookupable, DynamicNewable {
    
    public required override init() {
        super.init()
        self.params = [:]
    }
    
    
    public var params = [String: Any]()
    
    public init(_ params: [String: Any]) {
        self.params = params
    }
    
    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) {
        for item in args {
            params[item.0] = item.1
        }
    }
    
    
    public func toData() throws -> Data {
        try JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
    }
    
}
