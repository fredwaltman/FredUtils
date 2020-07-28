 //
//  FredsNetworkingTests.swift
//  FredUtilsTests
//
//  Created by Fred Waltman on 7/28/20.
//

import XCTest
@testable import FredUtils

final class FredsNetworkingTests: XCTestCase {

    func testLoadDataCall() {
         
        let manager = FredUtils.Networking.Manager()
        let expectation = XCTestExpectation(description: "called for data"
        )
        
        guard let url = URL(string: "https://FredWaltman.com") else {
            return XCTFail("Could not create URL properly")
        }
        
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData) :
                XCTAssertNotNil(returnedData, "Response data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error making error")
            }
        }
        
        wait(for: [expectation], timeout: 5)
        
    }
   


    static var allTests = [
        ("testLoadDataCall", testLoadDataCall)
    ]
}
