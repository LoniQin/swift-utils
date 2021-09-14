
//
//  FileLoggerTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class FileLoggerTestCase: XCTestCase {
    
    func testFileLogger() throws {
        let logger = try FileLogger(dataPath() / "file.log")
        try logger.log(message: "A", location: CodeLocation())
        try logger.log(message: "B", location: CodeLocation())
        try logger.log(message: "C", location: CodeLocation())
    }
    
}
