
//
//  HTTPTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class HTTPTestCase: XCTestCase {
    
    func testQueryParam() {
        HTTP.query(id: 888, phone: "11111111111", password: "123456").assert.equal("id=888&phone=11111111111&password=123456")
    }
    
    func testJSONParam() {
        let dictionary: [String : Any] = HTTP.json(id: 888, phone: "12345678901", password: "123456")
        let dic = ["id": "888", "phone": "12345678901", "password": "123456"]
        for (key, value) in dic {
            "\(dictionary[key]!)".assert.equal(value)
        }
    }
    
}
