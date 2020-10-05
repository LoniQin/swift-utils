//
//  DictionaryStorage.swift
//  
//
//  Created by lonnie on 2020/8/21.
//

import Foundation

public class DictionaryStorage: DataStorage {
    
    public static let `default` = DictionaryStorage()
    
    private let lock = NSLock()
    
    private var dictionary: [String: Any] = [:]
    
    public func get<T>(_ key: CustomStringConvertible) throws -> T where T : Decodable, T : Encodable {
        try lock.tryLock { [unowned self] in
            guard let value = self.dictionary[key.description] as? T else {
                throw FoundationError.nilValue
            }
            return value
        }
    }
    
    public func set<T>(_ value: T?, for key: CustomStringConvertible) throws where T : Decodable, T : Encodable {
        try lock.tryLock { [unowned self] in
            self.dictionary[key.description] = value
        }
    }
    
}
