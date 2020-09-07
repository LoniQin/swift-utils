import XCTest
@testable import FoundationLib

fileprivate struct Item {
    
    @Default(2) var intValue: Int!
    
    @Default(3) var doubleValue: Double!
    
    @Default("Hello") var stringValue: String!
    
    @AssociatedProperty var associatedProperty: Int!
    
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
    
    func testDipatchQueue() {
        do {
            try 2.assert.equal(DispatchQueue.sync { 1 + 1 })
            /*
            DispatchQueue.global().async {
                try 2.assert.equal(DispatchQueue.sync { 1 + 1 })
                return 0
            }
            */
        } catch {
            
        }
    }
    
    func testNumberConvertable() {
        2.int.assert.equal(2)
        2.uint.assert.equal(2)
        2.double.assert.equal(2)
        2.float.assert.equal(2)
        2.0.int.assert.equal(2)
        2.0.uint.assert.equal(2)
        2.0.double.assert.equal(2.0)
        2.0.float.assert.equal(2.0)
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
        let filePath = basePath  / "values.json"
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
    
    func testStringExtensions() {
        let str = "hello world"
        str.appendingSuffix(";").assert.equal("hello world;")
        str.appendingPrefix("Lonnie:").assert.equal("Lonnie:hello world")
        assert.equal(str.appendingSuffix(";"), "hello world;")
        assert.equal(str.appendingSuffix("world"), "hello world")
        assert.equal(str.appendingPrefix("hello"), "hello world")
        ("user" / "login").assert.equal("user/login")
        ("111" * 3).assert.equal("111111111")
        ("111" - "222").assert.equal("111-222")
    }
    
    func testDouble() {
        1.0.km.assert.equal(1000)
        1000.0.times(1000).assert.equal(1000000)
    }
    
    func testAssert() {
        1.assert.equal(1)
        true.assert.true()
        false.assert.false()
        1.assert.greaterThan(0)
        2.assert.lessThan(3)
        2.assert.lessThanOrEqual(2)
        3.assert.greaterThan(1)
        4.assert.greaterThanOrEqual(4)
        true.assert.true()
        false.assert.false()
    }
    
    func testDictonaryExtension() {
        let dic = ["a": 1, "b": 2]
        do {
            let a: Int = try dic.get("a")
            a.assert.equal(1)
            let b: Int? = dic.get("b")
            print(b)
        } catch  {
            XCTFail()
        }
        do {
            let _ : Int = try dic.get("c")
            XCTFail()
        } catch {
            
        }
        
    }
    
    func testArrayExtension() {
        let array: [Any] = [1, 3, 5, "7", 9]
        do {
            let a: Int = try array.get(0)
            a.assert.equal(1)
            let b: String = try array.get(3)
            b.assert.equal("7")
            let c: Int? = array.get(0)
            c.assert.equal(1)
            let d: Int? = array.get(100)
            d.assert.equal(nil)
        } catch  {
            XCTFail()
        }
        do {
            let _ : Int = try array.get(3)
            XCTFail()
        } catch {
            
        }
    }
    
    func testNSCacheStorage() {
        let storage = NSCacheStorage.default
        
        do {
            try storage.set(1, for: "key")
            let value: Int = try storage.get(for: "key")
            value.assert.equal(1)
        } catch {
            XCTFail()
        }
        
        do {
            let obj: Int? = nil
            try storage.set(obj, for: "key")
            let _: Int = try storage.get(for: "key")
            XCTFail()
        } catch {
            
        }
    }
    
    func testBuider() {
        class A: Buildable {
            var a = 1
            var b = 2
            var c = "ccc"
        }
        
        let a = A()
        let buider1 = a.builder
        let buider2 = a.builder
        XCTAssert(buider1 === buider2)
        a.builder.build {
            $0.a = 2
            $0.b = 3
            $0.c = "hello"
        }
        a.a.assert.equal(2)
        a.b.assert.equal(3)
        a.c.assert.equal("hello")
        
    }
    
    func testRegex() {
        Regex.email.validate(text: "abc@def.com").assert.true()
        Regex.email.validate(text: "abcdef.com").assert.false()
        Regex.url.validate(text: "http://google.com").assert.true()
        Regex.url.validate(text: "https://google.com").assert.true()
        Regex.url.validate(text: "https://google").assert.false()
        Regex.ip.validate(text: "1.1.1.1").assert.true()
        Regex.ip.validate(text: "111.111.111").assert.false()
        
        let text = "Open website http://www.google.com"
        let result = Regex.scan(text: text)
        result.assert.equal([.url: ["http://www.google.com"]])
    }
    
    static var allTests = [
        ("testUserDefaults", testUserDefaults),
        ("testUnwrappable", testUnwrappable)
    ]
}
