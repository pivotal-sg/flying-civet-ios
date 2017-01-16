//
//  FlyingCivetUITests.swift
//  FlyingCivetUITests
//
//  Created by pivotal on 10/1/17.
//  Copyright © 2017 pivotal. All rights reserved.
//

import XCTest

class FlyingCivetUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testKopiRunner() {
        let KOPI_RUN_TITLE_TEXT = "There are no active Kopi Runs right now."
        let kopiRunTitleLabel = XCUIApplication().staticTexts[KOPI_RUN_TITLE_TEXT]
        XCTAssert(kopiRunTitleLabel.exists, "\"\(KOPI_RUN_TITLE_TEXT)\" label does not exist")
        
        let START_KOPI_RUN_BUTTON_TEXT = "START A KOPI RUN"
        let startKopiRunButton = XCUIApplication().buttons[START_KOPI_RUN_BUTTON_TEXT]
        XCTAssert(startKopiRunButton.exists, "\"\(START_KOPI_RUN_BUTTON_TEXT)\" button does not exist")
    }
}
