//
//  QueryGenerator.swift
//  
//
//  Created by lonnie on 2020/9/27.
//

import Foundation
@dynamicCallable
public struct QueryGenerator {

    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) -> String {
        args.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
