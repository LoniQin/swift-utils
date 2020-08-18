import XCTest
@testable import FoundationLib

final class FoundationLibTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FoundationLib().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
