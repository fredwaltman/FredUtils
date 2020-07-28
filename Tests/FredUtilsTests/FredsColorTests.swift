import XCTest
@testable import FredUtils

final class FredsColorTests: XCTestCase {
    func testColorRedEqual() {
        let color = FredUtils.Color.fromHexString("FF0000")
      XCTAssertEqual(color, .red)
    }
    
    func testFredUtilColorsAreEqual() {
    
        let color = FredUtils.Color.fromHexString("006736")
        XCTAssertEqual(color, FredUtils.Color.fredColor)
    }
    
    func testSecondaryFredUtilColorsAreEqual() {
        
        let color = FredUtils.Color.fromHexString("FCFFFD")
        XCTAssertEqual(color, FredUtils.Color.secondaryColor)
        
    }
    static var allTests = [
      ("testColorRedEqual", testColorRedEqual),
      ("testFredUtilColorsAreEqual",  testFredUtilColorsAreEqual),
      ("testSecondaryFredUtilColorsAreEqual", testSecondaryFredUtilColorsAreEqual)
    ]
}
