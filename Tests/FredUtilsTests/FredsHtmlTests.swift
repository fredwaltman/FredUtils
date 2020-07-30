//
//  FredsHtmlTests.swift
//  FredUtilsTests
//
//  Created by Fred Waltman on 7/29/20.
//

import XCTest
@testable import FredUtils

class FredsHtmlTests: XCTestCase {

    
    func testAttributed() {
        let html = "Test html</p>"
        
        let expectation = XCTestExpectation(description: "called to convert")
        
        FredUtils.Html.toAttributed(html) { result in
            expectation.fulfill()
            switch result  {
                case .success(let returnedData) :
                    XCTAssertNotNil(returnedData, "no return data")
                case .failure(let error):
                    XCTFail(error?.localizedDescription ?? "error making error")
                }
            }
        
         wait(for: [expectation], timeout: 5)
        }

    static var allTests = [
        ("testAttributed", testAttributed)
    ]

}
