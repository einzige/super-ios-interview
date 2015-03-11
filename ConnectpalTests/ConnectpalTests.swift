import UIKit
import XCTest
import Connectpal

class ConnectpalTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestContructor() {
        APIRequest()
    }
    
    func testEmptyResponse() {
        var response = APIResponse(data: [String: AnyObject]())
        
        XCTAssertFalse(response.isSuccess())
        XCTAssertTrue(response.getData().count == 0)
        XCTAssertTrue(response.getToken() == nil)
    }
    
    func testResponseWithToken() {
        var response = APIResponse(data: ["api_token": "set"])
        
        XCTAssertTrue(response.getToken() == "set")
    }
    
    func testResponseWithData() {
        var data = ["data": ["One": 1, "Two": 2]]
        var response = APIResponse(data: data)
        var responseData = response.getData()
        
        XCTAssertTrue(responseData["One"] as Int == 1)
        XCTAssertTrue(responseData["Two"] as Int == 2)
    }
    
    func testSuccessResponse() {
        var response = APIResponse(data: ["status": "success"])
        XCTAssertTrue(response.isSuccess() == true)
    }
}
