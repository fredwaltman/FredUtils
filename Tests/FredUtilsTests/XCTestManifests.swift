import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FredsColorTests.allTests),
        testCase(FredsNetworkingTests.allTests),
        testCase(FredsHtmlTests.allTests)
    ]
    
}
#endif
