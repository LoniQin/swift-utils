//
//  FileStorage.swift
//  
//
//  Created by lonnie on 2020/8/21.
//

import Foundation

class FileStorage: DataStorageProtocol {
    
    fileprivate let jsonDecoder = JSONDecoder()

    fileprivate let jsonEncoder = JSONEncoder()
    
    let path: String
    
    var dictionary = [String: Any]()
    
    private let lock = NSLock()
    
    init(path: String) throws {
        
        self.path = path
        
    }
    
    func load() throws {
        try lock.tryLock { [unowned self] in
            let locked = lock.try()
            defer {
                if locked { lock.unlock() }
            }
            
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            let dic = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            if dic is [String: Any] {
                dictionary = dic as! [String :Any]
            } else {
                throw FoundationError.invalidCoding
            }
        }
    }
    
    func save() throws {
        try lock.tryLock { [unowned self] in
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let bak_path = path + "_bak"
            if FileManager.default.fileExists(atPath: path) {
                try FileManager.default.moveItem(at: URL(fileURLWithPath: path), to: URL(fileURLWithPath: bak_path))
            }
            let succeed = FileManager.default.createFile(atPath: path, contents: data, attributes: .none)
            if FileManager.default.fileExists(atPath: bak_path) {
                if succeed {
                    try FileManager.default.removeItem(atPath: bak_path)
                } else {
                    try FileManager.default.moveItem(at: URL(fileURLWithPath: bak_path), to: URL(fileURLWithPath: path))
                }
            }
        }
    }
    
    func get<T>(for key: CustomStringConvertible) throws -> T where T : Decodable, T : Encodable {
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
    
    func set<T>(_ value: T?, for key: CustomStringConvertible) throws where T : Decodable, T : Encodable {
        try lock.tryLock { [unowned self] in
            if let value = value {
                dictionary[key.description] = try jsonEncoder.encode(value).base64EncodedString()
            } else {
                dictionary.removeValue(forKey: key.description)
            }
        }
    }
    
}
