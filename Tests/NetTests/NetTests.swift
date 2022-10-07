import XCTest
@testable import Net

final class NetTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Net().text, "Hello, World!")
    }
}
