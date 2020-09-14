//
//  Validatable.swift
//  
//
//  Created by lonnie on 2020/9/14.
//

import Foundation
protocol Validatable {
    var rawValue: String { get }
}

extension Validatable {
    /// Validate text
    /// - Parameter text: Text
    /// - Returns: If the text is a valid for this regex.
    public func validate(text: String) -> Bool {
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,self.rawValue)
        return predicate.evaluate(with: text)
    }
    
    /// Find texts that matches this regex
    /// - Parameter text: Text
    /// - Throws: NSRegularExpression error
    /// - Returns: Texts that matches this regex
    public func matches(text: String) throws -> [String] {
        let regex = try NSRegularExpression(pattern: rawValue, options:[NSRegularExpression.Options.caseInsensitive])
        let results = regex.matches(in: text.lowercased(), options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.count))
        var strings = [String]()
        let nsText = text as NSString
        for result in results {
            strings.append(nsText.substring(with: result.range))
        }
        return strings
    }
}
