//
//  Filelogger.swift
//  
//
//  Created by lonnie on 2020/9/13.
//

import Foundation
public class FileLogger: Logging {
    
    public var path: String
    
    private var handle: FileHandle
    
    public init(_ path: String) throws {
        self.path = path
        try FileManager.default.createFileIfNotExist(path)
        if let handle = FileHandle(forUpdatingAtPath: path) {
            self.handle = handle
            self.handle.seekToEndOfFile()
        } else {
            throw FoundationError.nilValue
        }
    }
    
    public func log(message: Any..., level: Level = .verbose, location: CodeLocation = CodeLocation(file: #file, line: #line, function: #function)) throws {
        let desc =  "\(location.file) ~ \(location.function) ~ \(location.line): " + message.map { String(describing: $0) }.joined(separator: " ") + "\n"
        try handle.write(desc.data(.utf8))
    }
    
    deinit {
        handle.closeFile()
    }
    
}
