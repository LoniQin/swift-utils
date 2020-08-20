//
//  UserDefaults+Extension.swift
//
//
//  Created by lonnie on 2020/8/19.
//

import Foundation

public extension UserDefaults {
    
    func get<T>(_ key: CustomStringConvertible) -> T? {
        value(forKey: key.description) as? T
    }
    
    func set(_ any: Any, for key: CustomStringConvertible) {
        set(any, forKey: key.description)
    }
    
}
