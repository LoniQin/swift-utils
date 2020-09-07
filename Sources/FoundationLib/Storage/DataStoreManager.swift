//
//  DataStoreManager.swift
//  
//
//  Created by lonnie on 2020/8/24.
//

import Foundation
public class DataStoreManager: DataStorageStrategy {
    
    enum Strategy {
        case file(path: String)
        case memory
        case userDefaults(suiteName: String)
        case nsCache
    }
    
    let storage: DataStorageStrategy
    
    init(storage: DataStorageStrategy) {
        self.storage = storage
    }
    
    init(strategy: Strategy) throws {
        switch strategy {
        case .file(let path):
            self.storage = try FileStorage(path: path)
        case .memory:
            self.storage = MemoryCacheStorage()
        case .userDefaults(let suiteName):
            if let defaults = UserDefaults(suiteName: suiteName) {
                self.storage = defaults
            } else {
                throw FoundationError.nilValue
            }
        case .nsCache:
            self.storage = NSCacheStorage()
        }
    }
    
    public func get<T>(_ key: CustomStringConvertible) throws -> T where T : Decodable, T : Encodable {
        try storage.get(key)
    }
    public func set<T>(_ value: T?, for key: CustomStringConvertible) throws where T : Decodable, T : Encodable {
        try storage.set(value, for: key)
    }
    
    public func load() throws {
        try storage.load()
    }
    
    public func save() throws {
        try storage.save()
    }
}
