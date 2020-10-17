//
//  Character.swift
//  
//
//  Created by lonnie on 2020/10/17.
//

import Foundation

public extension Array where Element == Character {
    
    static var lowercasedAlphabets: [Character] {
        Array("abcdefghijklmnopqrstuvwxyz")
    }
    
    static var uppercasedAlphabets: [Character] {
        Array("abcdefghijklmnopqrstuvwxyz".uppercased())
    }
    
    static var alphabets: [Character] {
        lowercasedAlphabets + uppercasedAlphabets
    }
    
    static var numbers: [Character] {
        Array("0123456789")
    }
    
}
