//
//  FlyingCivetTests.swift
//  FlyingCivetTests
//
//  Created by pivotal on 10/1/17.
//  Copyright © 2017 pivotal. All rights reserved.
//

import XCTest
@testable import FlyingCivet

class FlyingCivetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLocationSelected() {
        let toastBoxButton = UIButton()
        toastBoxButton.tag = 1

        let workingCapitalCheckbox = UIImageView()
        workingCapitalCheckbox.alpha = 1

        let toastBoxCheckbox = UIImageView()
        toastBoxCheckbox.alpha = 0

        let lvc = LocationViewController()
        lvc.checkmarks = [workingCapitalCheckbox, toastBoxCheckbox]
        lvc.locationSelected(toastBoxButton)

        XCTAssertEqual(workingCapitalCheckbox.alpha, 0)
        XCTAssertEqual(toastBoxCheckbox.alpha, 1)
    }

}
