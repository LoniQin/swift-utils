//
//  DictionaryGenerator.swift
//  
//
//  Created by lonnie on 2020/9/27.
//

import Foundation
@dynamicCallable
public struct DictionaryGenerator {

    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) -> [String: Any] {
        var dic = [String : Any]()
        for item in args {
            dic[item.0] = item.1
        }
        return dic
    }
    
}
