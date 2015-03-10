//
//  ConnectpalTests.swift
//  ConnectpalTests
//
//  Created by Sergei Zinin on 06/03/15.
//  Copyright (c) 2015 Connectpal. All rights reserved.
//

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
    
    func testBaseUrl() {
        XCTAssertEqual(APIRequest().baseUrl, "http://localhost:3000/api")
    }
}
