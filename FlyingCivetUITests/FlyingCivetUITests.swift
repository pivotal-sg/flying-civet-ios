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
        let app = XCUIApplication()

        let KOPI_RUN_TITLE_TEXT = "There are no active Kopi Runs right now."
        let kopiRunTitleLabel = app.staticTexts[KOPI_RUN_TITLE_TEXT]
        XCTAssert(kopiRunTitleLabel.exists, "\"\(KOPI_RUN_TITLE_TEXT)\" label does not exist")
        
        let START_KOPI_RUN_BUTTON_TEXT = "START A KOPI RUN"
        let startKopiRunButton = app.buttons[START_KOPI_RUN_BUTTON_TEXT]
        XCTAssert(startKopiRunButton.exists, "\"\(START_KOPI_RUN_BUTTON_TEXT)\" button does not exist")

        startKopiRunButton.tap()
        
        let TOAST_BOX_TEXT = "Toast Box"
        app.buttons[TOAST_BOX_TEXT].tap()

        let TOAST_BOX_CHECKMARK_IDENTIFIER = "toast-box-checkmark"
        let toastBoxCheckmark = app.images[TOAST_BOX_CHECKMARK_IDENTIFIER]
        XCTAssert(toastBoxCheckmark.isHittable, "\"\(TOAST_BOX_CHECKMARK_IDENTIFIER)\" image does not exist")
        let THE_WORKING_CAPITAL_CHECKMARK_IDENTIFIER = "the-working-capital-checkmark"
        XCTAssert(!app.images[THE_WORKING_CAPITAL_CHECKMARK_IDENTIFIER].exists, "\"\(THE_WORKING_CAPITAL_CHECKMARK_IDENTIFIER)\" image should not exist, but it did")

        let WORKING_CAPITAL_TEXT = "The Working Capital"
        app.buttons[WORKING_CAPITAL_TEXT].tap()

        let START_TAKING_ORDERS_BUTTON_TEXT = "START TAKING ORDERS"
        let startTakingOrdersButton = app.buttons[START_TAKING_ORDERS_BUTTON_TEXT]
        XCTAssert(startTakingOrdersButton.exists, "\"\(START_TAKING_ORDERS_BUTTON_TEXT)\" button does not exist")
        
        startTakingOrdersButton.tap()

        let KOPI_RUN_TO_WORKING_CAPITAL_TEXT = "You are going on a Kopi Run to \(WORKING_CAPITAL_TEXT)"
        let kopiRunToWorkingCapitalLabel = app.staticTexts[KOPI_RUN_TO_WORKING_CAPITAL_TEXT]
        XCTAssert(kopiRunToWorkingCapitalLabel.exists, "\"\(KOPI_RUN_TO_WORKING_CAPITAL_TEXT)\" label does not exist")

        app.buttons["PLACE AN ORDER"].tap()
    }

}
