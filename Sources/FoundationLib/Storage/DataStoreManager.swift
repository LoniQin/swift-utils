//
//  DataStoreManager.swift
//  
//
//  Created by lonnie on 2020/8/24.
//

import Foundation
public class DataStoreManager: DataStorageStrategy {
    
    let storage: DataStorageStrategy
    
    init(storage: DataStorageStrategy) {
        self.storage = storage
    }
    
    public func get<T>(for key: CustomStringConvertible) throws -> T where T : Decodable, T : Encodable {
        try storage.get(for: key)
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
