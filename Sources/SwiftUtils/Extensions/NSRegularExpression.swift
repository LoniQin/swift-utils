//
//  NSRegularExpression.swift
//  
//
//  Created by lonnie on 2020/10/25.
//

import Foundation
public extension NSRegularExpression {
    
    static func urlExpression(options: NSRegularExpression.Options = []) throws -> NSRegularExpression {
        try NSRegularExpression(
            pattern: "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]",
            options: options
        )
    }
    
    func firstValidMatch(_ text: String, options: MatchingOptions = [], range: NSRange? = nil) -> NSTextCheckingResult? {
        let _range = range ?? NSMakeRange(0, text.count)
        if let match = firstMatch(in: text, options: options, range: _range), match.range.isValid {
            return match
        }
        return nil
    }
    
    func validate(_ text: String, options: MatchingOptions = [], range: NSRange? = nil) -> Bool {
        firstValidMatch(text, options: options, range: range) != nil
    }
    
}
