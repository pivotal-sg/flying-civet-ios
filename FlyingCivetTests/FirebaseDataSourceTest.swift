import XCTest

class FirebaseDataSourceTest: XCTestCase {
    func testParseMenuItems() {
        let firebase = FirebaseDataSource()
        let expectedMenuItems = [ MenuItem(name: "foo", type: .Drink) ]
        let firebaseMenuItems = [
            [ "name": "foo", "type": "Drink" ]
        ]

        let actualMenuItems = firebase.parseMenuItems(rawValue: firebaseMenuItems)

        XCTAssertEqual(expectedMenuItems, actualMenuItems)
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
