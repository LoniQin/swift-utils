//
//  Http.swift
//  
//
//  Created by lonnie on 2020/9/27.
//

import Foundation
public enum Http {
    
    public static let query = QueryGenerator()
    
    public static let json = DictionaryGenerator<Codable>()
    
    public static let header = DictionaryGenerator<String>()
    
}
