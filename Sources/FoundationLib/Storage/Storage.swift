//
//  Storage.swift
//
//
//  Created by lonnie on 2020/8/21.
//

import Foundation

@propertyWrapper
public class Storage<T: Codable> {
    
    var key: String
    
    let defaultValue: T
    
    let strategy: DataStorage
    
    public init(
        _ key: String,
        defaultValue: T,
        strategy: DataStorage = UserDefaults.standard
    ) {
        self.key = key
        self.defaultValue = defaultValue
        self.strategy = strategy
    }
 
    public var wrappedValue: T {
        get {
            do {
                return try strategy.get(key)
            } catch{
                return defaultValue
            }
        }
        set {
            do {
                try strategy.set(newValue, for: key)
            } catch let error {
                debugPrint(error)
            }
        }
    }

}
