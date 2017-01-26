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

        // Landing screen
        let KOPI_RUN_TITLE_TEXT = "There are no active Kopi Runs right now."
        let kopiRunTitleLabel = app.staticTexts[KOPI_RUN_TITLE_TEXT]
        XCTAssert(kopiRunTitleLabel.exists, "\"\(KOPI_RUN_TITLE_TEXT)\" label does not exist")
        
        let START_KOPI_RUN_BUTTON_TEXT = "START A KOPI RUN"
        let startKopiRunButton = app.buttons[START_KOPI_RUN_BUTTON_TEXT]
        XCTAssert(startKopiRunButton.exists, "\"\(START_KOPI_RUN_BUTTON_TEXT)\" button does not exist")

        // Start Kopi Run
        startKopiRunButton.tap()
        
        let TOAST_BOX_TEXT = "Toast Box"
        app.buttons[TOAST_BOX_TEXT].tap()

        let TOAST_BOX_CHECKMARK_IDENTIFIER = "toast-box-checkmark"
        let toastBoxCheckmark = app.images[TOAST_BOX_CHECKMARK_IDENTIFIER]
        XCTAssert(toastBoxCheckmark.isHittable, "\"\(TOAST_BOX_CHECKMARK_IDENTIFIER)\" image does not exist")
        let THE_WORKING_CAPITAL_CHECKMARK_IDENTIFIER = "the-working-capital-checkmark"
        XCTAssert(!app.images[THE_WORKING_CAPITAL_CHECKMARK_IDENTIFIER].exists, "\"\(THE_WORKING_CAPITAL_CHECKMARK_IDENTIFIER)\" image should not exist, but it did")

        // Select Kopi run location
        let WORKING_CAPITAL_TEXT = "The Working Capital"
        app.buttons[WORKING_CAPITAL_TEXT].tap()

        // Start taking orders
        let START_TAKING_ORDERS_BUTTON_TEXT = "START TAKING ORDERS"
        let startTakingOrdersButton = app.buttons[START_TAKING_ORDERS_BUTTON_TEXT]
        XCTAssert(startTakingOrdersButton.exists, "\"\(START_TAKING_ORDERS_BUTTON_TEXT)\" button does not exist")

        startTakingOrdersButton.tap()

        let KOPI_RUN_TO_WORKING_CAPITAL_TEXT = "You are going on a Kopi Run to \(WORKING_CAPITAL_TEXT)"
        let kopiRunToWorkingCapitalLabel = app.staticTexts[KOPI_RUN_TO_WORKING_CAPITAL_TEXT]
        XCTAssert(kopiRunToWorkingCapitalLabel.exists, "\"\(KOPI_RUN_TO_WORKING_CAPITAL_TEXT)\" label does not exist")

        // Place an order
        let PLACE_AN_ORDER_TEXT = "PLACE AN ORDER"
        app.buttons[PLACE_AN_ORDER_TEXT].tap()

        let WORKING_CAPITAL_ORDER_TITLE_TEXT = "What would you like from \(WORKING_CAPITAL_TEXT)?"
        let kopiRunOrderTitleText = app.staticTexts[WORKING_CAPITAL_ORDER_TITLE_TEXT]
        XCTAssert(kopiRunOrderTitleText.exists, "\"\(WORKING_CAPITAL_ORDER_TITLE_TEXT)\" label does not exist")

        // Initially, basket has size of 0
        let BASKET_COUNT_TEXT = "0"
        let initialBasketCountText = app.staticTexts[BASKET_COUNT_TEXT]
        XCTAssert(initialBasketCountText.exists, "\"\(BASKET_COUNT_TEXT)\" label does not exist")

        app.tables.staticTexts["Kopi (Coffee)"].tap()

        let CUSTOMIZE_TITLE_TEXT = "How would you like your Kopi?"
        let kopiRunCustomizeTitleText = app.staticTexts[CUSTOMIZE_TITLE_TEXT]
        XCTAssert(kopiRunCustomizeTitleText.exists, "\"\(CUSTOMIZE_TITLE_TEXT)\" label does not exist")

        app.tables.staticTexts["O (Black)"].tap()

        // Increase quantity
        app.steppers.buttons["Increment"].tap()

        let COFFEE_QUANTITY_LABEL_TEXT = "2"
        let coffeeQuantityLabel = app.staticTexts[COFFEE_QUANTITY_LABEL_TEXT]
        XCTAssert(coffeeQuantityLabel.exists, "\(COFFEE_QUANTITY_LABEL_TEXT) label does not exist")

        let ADD_TO_BASKET_TEXT = "ADD TO BASKET"
        app.buttons[ADD_TO_BASKET_TEXT].tap()

        // Check recent orders
        let KOPI_TEXT = "Kopi"
        let kopiText = app.staticTexts[KOPI_TEXT]
        XCTAssert(kopiText.exists, "\"\(KOPI_TEXT)\" label does not exist")

        let KOPI_QUANTITY_TEXT = "2x"
        let kopiQuantityText = app.staticTexts[KOPI_QUANTITY_TEXT]
        XCTAssert(kopiQuantityText.exists, "\"\(KOPI_QUANTITY_TEXT)\" label does not exist")

        let KOPI_VARIANTS_TEXT = "Hot O"
        let kopiVariantsText = app.staticTexts[KOPI_VARIANTS_TEXT]
        XCTAssert(kopiVariantsText.exists, "\"\(KOPI_VARIANTS_TEXT)\" label does not exist")

        app.tables.staticTexts["Kaya Toast"].tap()
        app.tables.staticTexts["Kaya Toast"].tap()
        app.tables.staticTexts["Kaya Toast"].tap()

        let UPDATED_BASKET_COUNT_TEXT = "5"
        let updatedBasketCountText = app.staticTexts[UPDATED_BASKET_COUNT_TEXT]
        XCTAssert(updatedBasketCountText.exists, "\"\(UPDATED_BASKET_COUNT_TEXT)\" label does not exist")

        // View basket
        let VIEW_BASKET_TEXT = "VIEW BASKET"
        app.buttons[VIEW_BASKET_TEXT].tap()

        XCTAssert(kopiText.exists, "\"\(KOPI_TEXT)\" label does not exist")
        XCTAssert(kopiQuantityText.exists, "\"\(KOPI_QUANTITY_TEXT)\" label does not exist")
        XCTAssert(kopiVariantsText.exists, "\"\(KOPI_VARIANTS_TEXT)\" label does not exist")

        let TOAST_TEXT = "Kaya Toast"
        let toastText = app.staticTexts[TOAST_TEXT]
        XCTAssert(toastText.exists, "\"\(TOAST_TEXT)\" label does not exist")

        let TOAST_QUANTITY_TEXT = "3x"
        let toastQuantityText = app.staticTexts[TOAST_QUANTITY_TEXT]
        XCTAssert(toastQuantityText.exists, "\"\(TOAST_QUANTITY_TEXT)\" label does not exist")

        let TOAST_VARIANTS_TEXT = "Traditional"
        let toastVariantsText = app.staticTexts[TOAST_VARIANTS_TEXT]
        XCTAssert(toastVariantsText.exists, "\"\(TOAST_VARIANTS_TEXT)\" label does not exist")

    }
}
