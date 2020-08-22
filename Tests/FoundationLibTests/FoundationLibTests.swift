import XCTest
@testable import FoundationLib

fileprivate struct Item {
    
    @Default(2) var intValue: Int?
    
    @Default(3) var doubleValue: Double?
    
    @Default("Hello") var stringValue: String?
    
    @AssociatedProperty var associatedProperty: Int?
    
}

final class FoundationLibTests: XCTestCase {
    
    let assert = Assert()
    
    func testUnwrappable() {
        var a: Int?
        var b: Double?
        var c: String?
        assert.equal(a.unwrapped, 0)
        assert.equal(b.unwrapped, 0)
        assert.equal(c.unwrapped, "")
        a = 1
        b = 2
        c = "3"
        assert.equal(a.unwrapped, 1)
        assert.equal(b.unwrapped, 2)
        assert.equal(c.unwrapped, "3")
    }
    
    func testMemoryCacheManager() {
        
        struct User: Codable, Equatable {
            let name: String
        }
        do {
            let storage = MemoryCacheStorage()
            let user = User(name: "Lonnie")
            try storage.load()
            try storage.set(user, for: "user")
            try storage.save()
            assert.equal(try storage.get(for: "user"), user)
        } catch let error {
            objc_exception_throw(error)
        }
    }
    
    func testUserDefaults() {
        
        struct User: Codable, Equatable {
            let name: String
        }
        
        do {
            let storage = UserDefaults.standard
            let user = User(name: "Lonnie")
            try storage.load()
            try storage.set(user, for: "user")
            try storage.save()
            assert.equal(try storage.get(for: "user"), user)
        } catch let error {
            objc_exception_throw(error)
        }
        
    }
    
    func testFileStorage() {
        
        var components = #file.components(separatedBy: "/")
        components.removeLast()
        
        let basePath = components.joined(separator: "/")
        let filePath = basePath + "/" + "values.json"
        struct User: Codable, Equatable {
            let name: String
        }
        
        do {
            let storage = try FileStorage(path: filePath)
            let user = User(name: "Lonnie")
            try storage.set(user, for: "user")
            try storage.save()
            assert.equal(try storage.get(for: "user"), user)
            
            let nextStorage = try FileStorage(path: filePath)
            try nextStorage.load()
            let nextUser: User = try nextStorage.get(for: "user")
            assert.equal(user, nextUser)
        } catch let error {
            objc_exception_throw(error)
        }
        
    }
    
    func testDefault() {
        
        var item = Item()
        assert.equal(item.intValue.unwrapped, 2)
        assert.equal(item.doubleValue.unwrapped, 3)
        assert.equal(item.stringValue.unwrapped, "Hello")
        item.intValue = 4
        item.doubleValue = 5
        item.stringValue = "World"
        assert.equal(item.intValue.unwrapped, 4)
        assert.equal(item.doubleValue.unwrapped, 5)
        assert.equal(item.stringValue.unwrapped, "World")
        assert.equal(item.associatedProperty, nil)
        item.associatedProperty = 8
        assert.equal(item.associatedProperty, 8)
        
    }
    
    func testDispatchQueueExtension() {
        self.try {
            let value = try DispatchQueue.sync { 2 + 3 + 5 }
            XCTAssertEqual(value, 10)
            
            let bigValue = try DispatchQueue.sync(on: .global(), block: { () -> Int in
                var sum = 0
                for i in 0..<100000 { sum += i }
                return sum
            })
            XCTAssert(4999950000 == bigValue)
        }
    }
    
    func testStringExtensions() {
        let str = "hello world"
        str.appendingSuffix(";").assert.equal("hello world;")
        str.appendingPrefix("Lonnie:").assert.equal("Lonnie:hello world")
        assert.equal(str.appendingSuffix(";"), "hello world;")
        assert.equal(str.appendingSuffix("world"), "hello world")
        assert.equal(str.appendingPrefix("hello"), "hello world")
    }
    
    func testDouble() {
        1.0.km.assert.equal(1000)
        1000.0.times(1000).assert.equal(1000000)
    }
    
    static var allTests = [
        ("testUserDefaults", testUserDefaults),
        ("testUnwrappable", testUnwrappable)
    ]
}
