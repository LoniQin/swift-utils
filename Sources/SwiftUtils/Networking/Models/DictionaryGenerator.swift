//
//  DictionaryGenerator.swift
//  
//
//  Created by lonnie on 2020/9/27.
//

import Foundation
@dynamicCallable
public struct DictionaryGenerator<Value> {
    
    public init() {
        
    }

    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Value>) -> [String: Value] {
        var dic = [String : Value]()
        for item in args {
            dic[item.0] = item.1
        }
        return dic
    }
    
}
