import XCTest
@testable import FoundationLib

final class FoundationLibTests: XCTestCase {
    
    func testUserDefaults() {
        UserDefaults.standard.set(1, for: 2)
        XCTAssert(UserDefaults.standard.get(2) == 1)
        UserDefaults.standard.set(5, for: "333")
        XCTAssert(UserDefaults.standard.get("333") == 5)
    }
    static var allTests = [
        ("testUserDefaults", testUserDefaults),
    ]
}
