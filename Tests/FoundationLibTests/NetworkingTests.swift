//
//  NetworkingTests.swift
//  
//
//  Created by lonnie on 2020/9/27.
//

import Foundation
import XCTest
import Compression
@testable import FoundationLib
final class NetworkingTests: XCTestCase {
    
    func testQueryParam() {
        Http.query(id: 888, phone: "11111111111", password: "123456").assert.equal("id=888&phone=11111111111&password=123456")
    }
    
    func testJSONParam() {
        let dictionary: [String : Any] = Http.json(id: 888, phone: "12345678901", password: "123456")
        let dic = ["id": "888", "phone": "12345678901", "password": "123456"]
        for (key, value) in dic {
            "\(dictionary[key]!)".assert.equal(value)
        }
    }
}
