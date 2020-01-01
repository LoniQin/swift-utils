//
//  UserDefaults.swift
//
//
//  Created by lonnie on 2020/8/19.
//

import Foundation

fileprivate let jsonDecoder = JSONDecoder()

fileprivate let jsonEncoder = JSONEncoder()

extension UserDefaults: DataStorageProtocol {
    
    public func load() throws {
        synchronize()
    }
    
    public func save() throws {
        synchronize()
    }
    
    public func get<T: Codable>(for key: CustomStringConvertible) throws -> T {
        guard let d = data(forKey: key.description) else { throw FoundationError.nilValue }
        let value = try jsonDecoder.decode(T.self, from: d)
        return value
    }
    
    public func set<T: Codable>(_ value: T?, for key: CustomStringConvertible) throws {
        let data =  try jsonEncoder.encode(value)
        set(data, forKey: key.description)
    }
    
}
