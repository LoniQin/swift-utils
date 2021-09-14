//
//  NetworkingTests.swift
//  
//
//  Created by lonnie on 2020/9/27.
//

import Foundation
import XCTest
import Compression
@testable import SwiftUtils

extension XCTestCase {
    
    func expectation(title: String = #function, timeout: TimeInterval = 30, block: (XCTestExpectation) throws -> Void) {
        let expectation = self.expectation(description: title)
        do {
            try block(expectation)
            self.waitForExpectations(timeout: 30) { (error) in
                if error != nil {
                    XCTFail(error.debugDescription)
                }
            }
        } catch let error {
            print(error)
        }
        
    }
    
    func download<T: ResponseConvertable>(_ request: RequestConvertable, title: String = #function, completion: @escaping (T) throws -> Void) {
        expectation(title: title) { (exp) in
            HttpClient.default.download(request) { (result: Result<T, Error>) in
                do {
                    let item = try result.get()
                    try completion(item)
                    exp.fulfill()
                } catch let error {
                    XCTFail(error.localizedDescription)
                }
            }
        }
    }
    
}
