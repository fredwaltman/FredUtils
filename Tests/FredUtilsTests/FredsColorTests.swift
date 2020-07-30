import XCTest
@testable import FredUtils

final class FredsColorTests: XCTestCase {
    func testColorRedEqual() {
        let color = FredUtils.Color.fromHexString("FF0000")
      XCTAssertEqual(color, .red)
    }

    static var allTests = [
      ("testColorRedEqual", testColorRedEqual)
    ]
}
