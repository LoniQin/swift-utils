import XCTest
@testable import FoundationLib
fileprivate struct Item {
    @Default(2) var intValue: Int?
    @Default(3) var doubleValue: Double?
    @Default("Hello") var stringValue: String?
    @AssociatedProperty var associatedProperty: Int?
}

final class FoundationLibTests: XCTestCase {
    
    func testUserDefaults() {
        UserDefaults.standard.set(1, for: 2)
        XCTAssert(UserDefaults.standard.get(2) == 1)
        UserDefaults.standard.set(5, for: "333")
        XCTAssert(UserDefaults.standard.get("333") == 5)
    }
    
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
    
    static var allTests = [
        ("testUserDefaults", testUserDefaults),
        ("testUnwrappable", testUnwrappable)
    ]
}
