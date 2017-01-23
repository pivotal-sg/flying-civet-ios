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

    func testParseMenuItems_withVariants() {
        let firebase = FirebaseDataSource()
        let itemVariants = [
            ItemVariant(name: "Normal", type: .Milk)
        ]
        let expectedMenuItems = [ MenuItem(name: "foo", type: .Drink, variants: itemVariants) ]

        let firebaseItemVariants = [
            [ "name": "Normal", "type": "Milk" ]
        ]
        let firebaseMenuItems = [
            [ "name": "foo", "type": "Drink", "variants": firebaseItemVariants]
        ]

        let actualMenuItems = firebase.parseMenuItems(rawValue: firebaseMenuItems)

        XCTAssertEqual(expectedMenuItems, actualMenuItems)
    }
}
