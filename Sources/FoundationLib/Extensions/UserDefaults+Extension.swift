//
//  UserDefaults+Extension.swift
//
//
//  Created by lonnie on 2020/8/19.
//

import Foundation

fileprivate let jsonDecoder = JSONDecoder()

fileprivate let jsonEncoder = JSONEncoder()

public extension UserDefaults {
    
    func get<T: Codable>(_ key: CustomStringConvertible) throws -> T {
        guard let d = data(forKey: key.description) else { throw FoundationError.nilValue }
        let value = try jsonDecoder.decode(T.self, from: d)
        return value
    }
    
    func set<T: Codable>(_ value: T?, for key: CustomStringConvertible) throws {
        let data =  try jsonEncoder.encode(value)
        set(data, forKey: key.description)
    }
    
}
