
//
//  HttpClientTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class HttpClientTestCase: XCTestCase {
    
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
                    result.id.assert.equal(1)
                    result.name.assert.equal("Lonnie")
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
            request.url?.absoluteString.assert.equal("https://www.example.com/user/signup")
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
    
    
    
    func testDownloadImage() {
        #if canImport(UIKit)
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
        #endif
    }
    
}
