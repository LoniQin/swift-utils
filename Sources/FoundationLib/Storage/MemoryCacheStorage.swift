//
//  MemoryCacheStorage.swift
//  
//
//  Created by lonnie on 2020/8/21.
//

import Foundation

class MemoryCacheStorage: DataStorageProtocol {
    
    static let `default` = MemoryCacheStorage()
    
    private let lock = NSLock()
    
    private var dictionary: [String: Any] = [:]
    
    func get<T>(for key: CustomStringConvertible) throws -> T where T : Decodable, T : Encodable {
        defer { lock.unlock() }
        lock.lock()
        guard let value = dictionary[key.description] as? T else {
            throw FoundationError.nilValue
        }
        return value
    }
    
    func set<T>(_ value: T?, for key: CustomStringConvertible) throws where T : Decodable, T : Encodable {
        defer { lock.unlock() }
        lock.lock()
        dictionary[key.description] = value
    }
    
    func load() throws {
        
    }
    
    func save() throws {
        
    }
    
}
