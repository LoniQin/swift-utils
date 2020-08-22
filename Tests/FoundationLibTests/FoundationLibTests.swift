import XCTest
@testable import FoundationLib
fileprivate struct Item {
    @Default(2) var intValue: Int?
    @Default(3) var doubleValue: Double?
    @Default("Hello") var stringValue: String?
    @AssociatedProperty var associatedProperty: Int?
}

final class FoundationLibTests: XCTestCase {
    
    func testUnwrappable() {
        var a: Int?
        var b: Double?
        var c: String?
        XCTAssertEqual(a.unwrapped, 0)
        XCTAssertEqual(b.unwrapped, 0)
        XCTAssertEqual(c.unwrapped, "")
        a = 1
        b = 2
        c = "3"
        XCTAssertEqual(a.unwrapped, 1)
        XCTAssertEqual(b.unwrapped, 2)
        XCTAssertEqual(c.unwrapped, "3")
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
            XCTAssertEqual(try storage.get(for: "user"), user)
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
            XCTAssertEqual(try storage.get(for: "user"), user)
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
            XCTAssertEqual(try storage.get(for: "user"), user)
            
            let nextStorage = try FileStorage(path: filePath)
            try nextStorage.load()
            let nextUser: User = try nextStorage.get(for: "user")
            XCTAssertEqual(user, nextUser)
        } catch let error {
            objc_exception_throw(error)
        }
        
    }
    
    func testDefault() {
        
        var item = Item()
        XCTAssertEqual(item.intValue.unwrapped, 2)
        XCTAssertEqual(item.doubleValue.unwrapped, 3)
        XCTAssertEqual(item.stringValue.unwrapped, "Hello")
        item.intValue = 4
        item.doubleValue = 5
        item.stringValue = "World"
        XCTAssertEqual(item.intValue.unwrapped, 4)
        XCTAssertEqual(item.doubleValue.unwrapped, 5)
        XCTAssertEqual(item.stringValue.unwrapped, "World")
        XCTAssertEqual(item.associatedProperty, nil)
        item.associatedProperty = 8
        XCTAssertEqual(item.associatedProperty, 8)
        
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
    
    static var allTests = [
        ("testUserDefaults", testUserDefaults),
        ("testUnwrappable", testUnwrappable)
    ]
}
