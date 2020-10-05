import XCTest
@testable import FoundationLib

final class FoundationLibTests: XCTestCase {
    
    struct Item {
        
        @Default(2) var intValue: Int!
        
        @Default(3) var doubleValue: Double!
        
        @Default("Hello") var stringValue: String!
        
        @AssociatedProperty var associatedProperty: Int!
        
        @AssociatedProperty var associatedProperty2: String!
        
    }
    
    struct User: Codable, Equatable {
        let name: String
    }
    
    func testUnwrappable() {
        var a: Int?
        var b: Double?
        var c: String?
        a.unwrapped.assert.equal(0)
        b.unwrapped.assert.equal(0)
        c.unwrapped.assert.equal("")
        a = 1
        b = 2
        c = "3"
        a.assert.equal(1)
        b.assert.equal(2)
        c.assert.equal("3")
    }
    
    func testDipatchQueue() {
        do {
            try 2.assert.equal(DispatchQueue.sync { 1 + 1 })
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
    
    func testMemoryCacheManager() throws {
        let storage = MemoryCacheStorage()
        let user = User(name: "Lonnie")
        try storage.load()
        try storage.set(user, for: "user")
        try storage.save()
        try user.assert.equal(storage.get("user"))
    }
    
    func testUserDefaults() throws {
        
        struct User: Codable, Equatable {
            let name: String
        }
        let storage = UserDefaults.standard
        let user = User(name: "Lonnie")
        try storage.load()
        try storage.set(user, for: "user")
        try storage.save()
        try user.assert.equal(storage.get("user"))
    }
    
    func testFileStorage() throws {
        let filePath = dataPath()  / "values.json"
        struct User: Codable, Equatable {
            let name: String
        }
        let storage = try FileStorage(path: filePath)
        let user = User(name: "Lonnie")
        try storage.set(user, for: "user")
        try storage.save()
        try user.assert.equal(storage.get("user"))
        let nextStorage = try FileStorage(path: filePath)
        try nextStorage.load()
        let nextUser: User = try nextStorage.get("user")
        user.assert.equal(nextUser)
    }
    
    func testDefault() {
        var item = Item()
        item.intValue.unwrapped.assert.equal(2)
        item.doubleValue.unwrapped.assert.equal(3)
        item.stringValue.unwrapped.assert.equal("Hello")
        item.intValue = 4
        item.doubleValue = 5
        item.stringValue = "World"
        item.intValue.unwrapped.assert.equal(4)
        item.doubleValue.unwrapped.assert.equal(5)
        item.stringValue.unwrapped.assert.equal("World")
        item.associatedProperty.assert.equal(nil)
        item.associatedProperty = 8
        item.associatedProperty.assert.equal(8)
        item.associatedProperty2.assert.equal(nil)
        item.associatedProperty2 = "Hello"
        item.associatedProperty2.assert.equal("Hello")
        item.associatedProperty2 = "Hello world"
        item.associatedProperty2.assert.equal("Hello world")
        
    }
    
    func testStringExtensions() {
        let str = "hello world"
        str.appendingSuffix(";").assert.equal("hello world;")
        str.appendingPrefix("Lonnie:").assert.equal("Lonnie:hello world")
        str.appendingSuffix(";").assert.equal("hello world;")
        str.appendingSuffix("world").assert.equal("hello world")
        str.appendingPrefix("hello").assert.equal("hello world")
        ("user" / "login").assert.equal("user/login")
        ("111" * 3).assert.equal("111111111")
        ("111" - "222").assert.equal("111-222")
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
            b.assert.equal(2)
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
            let value: Int = try storage.get("key")
            value.assert.equal(1)
        } catch {
            XCTFail()
        }
        
        do {
            let obj: Int? = nil
            try storage.set(obj, for: "key")
            let _: Int = try storage.get("key")
            XCTFail()
        } catch {
            
        }
    }
    
    func testBuider() {
        class A: NSObject, Buildable {
            
            typealias BuilderClass = Builder<A>
            
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
    
    func testStorageManager() {
        let storageManager = DataStoreManager(storage: UserDefaults.standard)
        do {
            try storageManager.load()
            let a = User(name: "Tom")
            try storageManager.set(a, for: "user")
            try a.assert.equal(storageManager.get("user"))
            try storageManager.save()
            XCTAssert(try DataStoreManager(strategy: .memory).storage is MemoryCacheStorage)
            XCTAssert(try DataStoreManager(strategy: .userDefaults(suiteName: "hello")).storage is UserDefaults)
            XCTAssert(try DataStoreManager(strategy: .nsCache).storage is NSCacheStorage)
            XCTAssert(try DataStoreManager(strategy: .file(path: "a.json")).storage is FileStorage)
            
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFileLogger() throws {
        let logger = try FileLogger(dataPath() / "file.log")
        try logger.log(.verbose, "A")
        try logger.log(.verbose, "B")
        try logger.log(.verbose, "C")
    }
    
    func testArrayBuilder() {
        var array = Array {
            1
            2
            3
            4
            5
        }
        array.assert.equal([1, 2, 3, 4, 5])
        
        array.append {
            6
            7
            8
            9
            10
        }
        array.assert.equal([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    }
    
    func testDictionaryWithArrayBuilder() {
        let dic = Dictionary {
            ("A", 1)
            ("B", 2)
            ("C", 3)
            ("D", 4)
        }
        dic.assert.equal(["A": 1, "B": 2, "C": 3, "D": 4])
    }
    
    func testJSONObject() {
        let jsonObject = JSONObject([
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
    }
    
    func testKeyPathConfigurable() {
        class A: Configurable {
            var a = 1
            var b = ""
            var c = 3
        }
        let a = A()
        a.with(\.a, 2).with(\.b, "b").with(\.c, 4)
        a.a.assert.equal(2)
        a.b.assert.equal("b")
        a.c.assert.equal(4)
    }
    
    func testLocalization() {
        if let bundle = Bundle(path: dataPath() / "test.bundle") {
            let localization = Localization(tableName: "test", bundle: bundle)
            localization.string(for: "a").assert.equal("1")
            localization.string(for: "b").assert.equal("2")
            localization.string(for: "c").assert.equal("3")
            localization.a.assert.equal("1")
            localization.b.assert.equal("2")
            localization.c.assert.equal("3")
        }
    }
    
    func testDynamicObject() {
        let dog = DynamicObject.new(name: "Lily", age: 12)
        dog.name.assert.equal("Lily")
        dog.age.assert.equal(12)
        dog.increaseAge = {
            dog.age += 1
        }
        dog.increaseAge()
        dog.age.assert.equal(13)
    }
    
    static var allTests = [
        ("testUserDefaults", testUserDefaults),
        ("testUnwrappable", testUnwrappable)
    ]
}
