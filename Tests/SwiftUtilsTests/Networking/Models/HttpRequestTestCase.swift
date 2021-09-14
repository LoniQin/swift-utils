
//
//  HttpRequestTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class HttpRequestTestCase: XCTestCase {
    
    func testHttpRequest() throws {
        var request = HttpRequest(
            domain: "http://www.example.com",
            paths: ["user", "login"],
            method: .post,
            query: HTTP.query(id: 1, name: "Jack"),
            body: HTTP.json(id: 1, name: "Jack"),
            header: HTTP.header(phone: "1", password: "2")
        )
        let req = try request.toURLRequest()
        req.url?.absoluteString.assert.equal("http://www.example.com/user/login?id=1&name=Jack")
        try request.body?.toData().assert.equal(req.httpBody ?? Data())
        req.allHTTPHeaderFields?.assert.equal(["phone": "1", "password": "2"])
        
        request = HttpRequest(
            domain: "https://www.example.com",
            paths: ["user", "login"],
            method: .get,
            query: HTTP.query(phone: "123456", password: "123456"),
            header: HTTP.header(A: "1")
        )
        do {
            let urlRequest = try request.toURLRequest()
            XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["A": "1"])
            XCTAssertEqual(urlRequest.url?.absoluteString, "https://www.example.com/user/login?phone=123456&password=123456")
            XCTAssertEqual(urlRequest.httpMethod, "GET")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
        request = HttpRequest(
            domain: "https://www.example.com",
            paths: ["user", "signup"],
            method: .post,
            body: ["phone": "123456", "password": "123456"],
            header: ["Content-Type": "application/json"]
        )

    }
    
}
