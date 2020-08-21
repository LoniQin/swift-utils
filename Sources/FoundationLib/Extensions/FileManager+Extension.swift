//
//  FileManager+Extension.swift
//
//
//  Created by lonnie on 2020/8/19.
//

import Foundation

public extension FileManager {
    
    func createDirectoryIfNotExist(_ path: String, withIntermediateDirectories: Bool = false) throws {
        if !FileManager.default.fileExists(atPath: path) {
            try createDirectory(atPath: path, withIntermediateDirectories: withIntermediateDirectories, attributes: nil)
        }
    }
    
    func createFileIfNotExist(_ path: String, data: Data = Data(), withIntermediateDirectories: Bool = false) throws {
        if !FileManager.default.fileExists(atPath: path) {
            createFile(atPath: path, contents: data, attributes: nil)
        }
    }
    
}
