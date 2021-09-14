
//
//  JSONObjectTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class JSONObjectTestCase: XCTestCase {
    
    func testJSONObject() throws {
        var jsonObject = JSONObject([
            "a": 1,
            "b": 2.2,
            "c": "hello"
        ])
        jsonObject.a.assert.equal(1)
        jsonObject.a = 5
        jsonObject.a.assert.equal(5)
        jsonObject.b.assert.equal(2.2)
        jsonObject.c.assert.equal("hello")
        jsonObject.x = 5
        jsonObject.x.assert.equal(5)
        jsonObject.y = 10.1
        jsonObject.y.assert.equal(10.1)
        jsonObject.title = "Hello world"
        jsonObject.title.assert.equal("Hello world")
        jsonObject.x = "888"
        jsonObject.x.assert.equal("888")
        jsonObject(e: 7, f: 8, g: 9)
        jsonObject.e.assert.equal(7)
        jsonObject.f.assert.equal(8)
        jsonObject.g.assert.equal(9)
        jsonObject.1 = "ASDF"
        jsonObject.1.assert.equal("ASDF")
        
        let data = try jsonObject.toData()
        let jsonObject2 = try JSONObject(data)
        for (key, _) in jsonObject.params {
            "\(jsonObject.params[key]!)".assert.equal("\(jsonObject2.params[key]!)")
        }
        jsonObject = JSONObject.new()
        jsonObject.params.count.assert.equal(0)
    }
    
}
