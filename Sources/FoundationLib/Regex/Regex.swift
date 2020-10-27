//
//  Regex.swift
//
//
//  Created by lonnie on 2020/9/6.
//

import Foundation

public enum Regex: String, CaseIterable, Validatable {
    
    case email = "([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})"
    
    case url = "(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?"
    
    case ip = "(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
    
    case chineseCharacter = "[\\u4e00-\\u9fa5]{1,}"
    
    case alphaNumeric = "[A-Za-z0-9]+"
    
    /// Scan text and find useful pattern
    /// - Parameter text: Text
    /// - Returns: Patterns
    static func scan(text: String) -> [Regex: [String]] {
        var dic = [Regex: [String]]()
        for item in allCases {
            do {
                let strings = try item.matches(text: text)
                if !strings.isEmpty {
                    dic[item] = strings
                }
            } catch let error {
                print(error)
            }
        }
        return dic
    }
    
}
