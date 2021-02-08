import XCTest
@testable import SGDS

final class SGDSTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SGDS().text, "Hello, World!")
    }

	func SGDSStackTest() {
		let testStack = Stack<Int>()

		testStack.push(1)
		XCTAssertEqual(testStack.count(), 1)
		XCTAssertEqual(testStack.isEmpty, false)

		let thePopped = testStack.pop()
		XCTAssertEqual(thePopped, 1)

		XCTAssertEqual(testStack.count(), 0)

		XCTAssertEqual(testStack.isEmpty, true)

	}

    static var allTests = [
        ("testExample", testExample),
    ]
}
