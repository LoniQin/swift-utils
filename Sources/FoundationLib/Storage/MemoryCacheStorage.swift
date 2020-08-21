//
//  MemoryCacheStorage.swift
//  
//
//  Created by lonnie on 2020/8/21.
//

import Foundation

public class MemoryCacheStorage: DataStorageProtocol {
    
    public static let `default` = MemoryCacheStorage()
    
    private let lock = NSLock()
    
    private var dictionary: [String: Any] = [:]
    
    public func get<T>(for key: CustomStringConvertible) throws -> T where T : Decodable, T : Encodable {
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
    
    public func load() throws {
        
    }
    
    public func save() throws {
        
    }
    
}
