import XCTest
@testable import FredUtils

final class FredUtilsTests: XCTestCase {
    func testColorRedEqual() {
      let color = FredUtils.colorFromHexString("FF0000")
      XCTAssertEqual(color, .red)
    }
    
    func testFredUtilColorsAreEqual() {
    
        let color = FredUtils.colorFromHexString("006736")
        XCTAssertEqual(color, FredUtils.fredColor)
    }
    
    func testSecondaryFredUtilColorsAreEqual() {
        
        let color = FredUtils.colorFromHexString("FCFFFD")
        XCTAssertEqual(color, FredUtils.secondaryColor)
        
    }
    static var allTests = [
      ("testColorRedEqual", testColorRedEqual),
      ("testFredUtilColorsAreEqual",  testFredUtilColorsAreEqual),
      ("testSecondaryFredUtilColorsAreEqual", testSecondaryFredUtilColorsAreEqual)
    ]
}
