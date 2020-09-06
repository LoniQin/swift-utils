//
//  FileStorage.swift
//  
//
//  Created by lonnie on 2020/8/21.
//

import Foundation

public class FileStorage: DataStorageStrategy {
    
    fileprivate let jsonDecoder = JSONDecoder()

    fileprivate let jsonEncoder = JSONEncoder()
    
    public let path: String
    
    var dictionary = [String: Any]()
    
    private let lock = NSLock()
    
    public init(path: String) throws {
        
        self.path = path
        
    }
    
    public func load() throws {
        try lock.tryLock { [unowned self] in
            
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            let dic = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            if dic is [String: Any] {
                self.dictionary = dic as! [String :Any]
            } else {
                throw FoundationError.invalidCoding
            }
        }
    }
    
    public func save() throws {
        try lock.tryLock { [unowned self] in
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let bak_path = self.path + "_bak"
            if FileManager.default.fileExists(atPath: self.path) {
                try FileManager.default.moveItem(at: URL(fileURLWithPath: self.path), to: URL(fileURLWithPath: bak_path))
            }
            let succeed = FileManager.default.createFile(atPath: self.path, contents: data, attributes: .none)
            if FileManager.default.fileExists(atPath: bak_path) {
                if succeed {
                    try FileManager.default.removeItem(atPath: bak_path)
                } else {
                    try FileManager.default.moveItem(at: URL(fileURLWithPath: bak_path), to: URL(fileURLWithPath: self.path))
                }
            }
        }
    }
    
    public func get<T>(for key: CustomStringConvertible) throws -> T where T : Decodable, T : Encodable {
        try lock.tryLock { [unowned self] in
            guard let base64Encoded = self.dictionary[key.description] as? String else {
                throw FoundationError.nilValue
            }
            guard let data = Data(base64Encoded: base64Encoded) else {
                throw FoundationError.invalidCoding
            }
            return try self.jsonDecoder.decode(T.self, from: data)
        }
    }
    
    public func set<T>(_ value: T?, for key: CustomStringConvertible) throws where T : Decodable, T : Encodable {
        try lock.tryLock { [unowned self] in
            if let value = value {
                self.dictionary[key.description] = try jsonEncoder.encode(value).base64EncodedString()
            } else {
                self.dictionary.removeValue(forKey: key.description)
            }
        }
    }
    
}
