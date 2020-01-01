//
//  FileManager.swift
//
//
//  Created by lonnie on 2020/8/19.
//

import Foundation

public extension FileManager {
    
    func filePath(in directory: SearchPathDirectory, path: String) throws -> String {
        guard let base = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first else {
            throw FoundationError.fileNotExist
        }
        return base / path
    }
    
    func createDirectoryIfNotExist(in directory: SearchPathDirectory, path: String, withIntermediateDirectories: Bool = true) throws {
        try createDirectoryIfNotExist(filePath(in: directory, path: path), withIntermediateDirectories: withIntermediateDirectories)
    }
    
    func createDirectoryIfNotExist(_ path: String, withIntermediateDirectories: Bool = false, attributes: [FileAttributeKey : Any]? = nil) throws {
        if !fileExists(atPath: path) {
            try createDirectory(atPath: path, withIntermediateDirectories: withIntermediateDirectories, attributes: attributes)
        }
    }
    
    func createFileIfNotExist(_ path: String, data: Data = Data()) throws {
        if !fileExists(atPath: path) {
            createFile(atPath: path, contents: data, attributes: nil)
        }
    }
    
}
