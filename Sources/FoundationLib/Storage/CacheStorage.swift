//
//  CacheStorage.swift
//  
//
//  Created by lonnie on 2020/9/6.
//

import Foundation

public class CacheStorage: DataStorage {
    
    public init() {}
    
    public static let `default` = CacheStorage()
    
    private var cache = NSCache<NSString, AnyObject>()
    
    public func get<T>(_ key: CustomStringConvertible) throws -> T where T : Decodable, T : Encodable {
        if let value = cache.object(forKey: key.description as NSString) as? T { return value }
        throw FoundationError.nilValue
    }
    
    public func set<T>(_ value: T?, for key: CustomStringConvertible) throws where T : Decodable, T : Encodable {
        if let val = value {
            cache.setObject(val as AnyObject, forKey: key.description as NSString)
        } else {
            cache.removeObject(forKey: key.description as NSString)
        }
    }
    
}
