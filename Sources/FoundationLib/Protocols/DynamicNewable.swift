//
//  DynamicNewable.swift
//  
//
//  Created by lonnie on 2020/10/10.
//

import Foundation

@dynamicCallable
public protocol DynamicNewable: NSObjectProtocol {
    
    var params: [String: Any] { get set }
    
    init()
    
}

extension DynamicNewable {
    
    public static var new: Self {
        return Self.init()
    }
    
    @discardableResult
    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) -> Self {
        for item in args {
            params[item.0] = item.1
        }
        return self
    }
    
}

