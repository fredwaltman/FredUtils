import XCTest
@testable import FredUtils

final class FredUtilsTests: XCTestCase {
    func testColorRedEqual() {
      let color = FredUtils.colorFromHexString("FF0000")
      XCTAssertEqual(color, .red)
    }
    
    static var allTests = [
      ("testColorRedEqual", testColorRedEqual)
    ]
}
