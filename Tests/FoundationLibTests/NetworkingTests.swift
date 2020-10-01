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
    
    func testHttpRequest() throws {
        var request = HttpRequest(
            domain: "http://www.example.com",
            paths: ["user", "login"],
            method: .post,
            query: Http.query(id: 1, name: "Jack"),
            body: Http.json(id: 1, name: "Jack"),
            header: Http.header(phone: "1", password: "2")
        )
        let req = try request.toURLRequest()
        req.url?.absoluteString.assert.equal("http://www.example.com/user/login?id=1&name=Jack")
        try request.body?.toData().assert.equal(req.httpBody ?? Data())
        req.allHTTPHeaderFields?.assert.equal(["phone": "1", "password": "2"])
        
        request = HttpRequest(
            domain: "https://www.example.com",
            paths: ["user", "login"],
            method: .get,
            query: Http.query(phone: "123456", password: "123456"),
            header: Http.header(A: "1")
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
    
    func expectation(title: String = #function, timeout: TimeInterval = 30, block: (XCTestExpectation) -> Void) {
        let expectation = self.expectation(description: title)
        block(expectation)
        self.waitForExpectations(timeout: 30) { (error) in
            if error != nil {
                XCTFail(error.debugDescription)
            }
        }
    }

    struct User: JSON {
        let id: Int
        let name: String
    }
    
    func testSendAndReceiveRequest1() {
        let expectation = self.expectation(description: "test request")
        HttpClient.default.send("https://github.com/LoniQin/Crypto/blob/master/README.md") { (result: Result<Data,Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                print(data)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30) { (error) in
            
        }
        
    }
    
    func testSendAndReceiveRequest2() {
        let expectation = self.expectation(description: "test request")
        HttpClient.default.send("https://github.com/LoniQin/Crypto/blob/master/README.md") { (result: Result<String, Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                print(data)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30) { (error) in
            
        }
        
    }
    
    func testHttpClientWithHttpRequest() {
        
        let request = HttpRequest(domain: "https://github.com", paths: ["LoniQin", "Crypto", "blob", "master", "README.md"], method: .get)
        XCTAssertEqual(try request.toURLRequest().url, try "https://github.com/LoniQin/Crypto/blob/master/README.md".toURLRequest().url)
        let expectation = self.expectation(description: "test request")
        HttpClient.default.send(request) { (result: Result<String, Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                print(data)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30) { (error) in
            
        }
        
    }
    
    func testHttpClientWithURLAndURLRequest() {
        let expectation = self.expectation(description: "test request")
        HttpClient.default.send(URLRequest(url: URL(string: "https://github.com/LoniQin/Crypto/blob/master/README.md")!)) { (result: Result<String, Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                print(data)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30) { (error) in
            
        }
        
    }
    
    func testHttpClientWithURL() {
        let expectation = self.expectation(description: "test request")
        HttpClient.default.send(URL(string: "https://github.com/LoniQin/Crypto/blob/master/README.md")!) { (result: Result<String, Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                print(data)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30) { (error) in
            
        }
        
    }

    func testGetMockUser() {
        self.expectation { (expectation) in
            let filePath = dataPath() / "mockUser.json"
            HttpClient.default.send(URL(fileURLWithPath: filePath)) { (result: Result<User, Error>) in
                do {
                    let result = try result.get()
                    XCTAssert(result.id == 1)
                    XCTAssert(result.name == "Jack")
                    let data = try result.toData()
                    XCTAssert(data.count > 0)
                    expectation.fulfill()
                } catch let error {
                    XCTFail(error.localizedDescription)
                }
            }
        }
    }
    
    func testDataConvertable() {
        let data = Data()
        XCTAssertEqual(try data.toData(), data)
    }
    func testForm() {
        let form = Form(
            domain: "https://www.example.com",
            paths: ["user", "signup"],
            items: [
                .init(key: "phone", value: .string("123456")),
                .init(key: "password", value: .string("123456")),
                .init(key: "text", value: .data(data: Data(), contentType: .plain, fileName: "aaa.txt"))
        ])
        do {
            let request = try form.toURLRequest()
            XCTAssertEqual(request.url?.absoluteString, "https://www.example.com/user/signup")
            let contentType = request.value(forHTTPHeaderField: "Content-Type")
            XCTAssertEqual(contentType?.hasPrefix("multipart/form-data;"), true)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testProcessOptions() {
        var options = ProcessOptions(.hmac(.sha1))
        options[.key].assert.equal(Optional<Data>.none)
        var data = Data(random: 16)
        options[.key] = data
        options[.key].assert.equal(data)
        options.key.assert.equal(data)
        data = Data(random: 16)
        options.key = data
        options.key.assert.equal(data)
    }
    
    #if canImport(UIKit)
    
    func testDownloadImage() {
        self.expectation { expectation in
            let imagePath = dataPath() / "cat.jpg"
            print(imagePath)
            HttpClient.default.send(URL(fileURLWithPath: imagePath)) { (result: Result<UIImage, Error>) in
                do {
                    _ = try result.get()
                    expectation.fulfill()
                } catch let error {
                    XCTFail(error.localizedDescription)
                }
            }
        }
    }
    
    #endif
    
}
