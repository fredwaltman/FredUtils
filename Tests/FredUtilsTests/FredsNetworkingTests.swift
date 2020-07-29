 //
//  FredsNetworkingTests.swift
//  FredUtilsTests
//
//  Created by Fred Waltman on 7/28/20.
//

import XCTest
@testable import FredUtils

 class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?
    
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
 
    
    
 }
 
final class FredsNetworkingTests: XCTestCase {

    func testLoadDataCall() {
         
        let manager = FredUtils.Networking.Manager()
        let session = NetworkSessionMock()
        manager.session = session
        
        let expectation = XCTestExpectation(description: "called for data"
        )
        
        let data = Data([0, 1, 0, 1])
        session.data = data
        let url = URL(fileURLWithPath: "url")
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData) :
                XCTAssertEqual(data, returnedData, "unexpected data")
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
