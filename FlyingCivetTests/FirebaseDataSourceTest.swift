import XCTest

class FirebaseDataSourceTest: XCTestCase {
    func testParseMenuItems() {
        let firebase = FirebaseDataSource()
        let expectedMenuItems = [ MenuItem(name: "foo", type: .Drink) ]
        let firebaseMenuItems = [
            [ "name": "foo", "detailed_name": "Normal", "type": "Drink" ]
        ]

        let actualMenuItems = firebase.parseMenuItems(rawValue: firebaseMenuItems)

        XCTAssertEqual(expectedMenuItems, actualMenuItems)
    }

    func testParseMenuItems_withVariants() {
        let firebase = FirebaseDataSource()
        let itemVariants = [
            ItemVariant(name: "Normal",
                        detailedName: "Normal",
                        type: .Milk)
        ]
        let expectedMenuItems = [ MenuItem(name: "foo", detailedName: "foo",  type: .Drink, variants: itemVariants) ]

        let firebaseItemVariants = [
            [ "name": "Normal",
              "detailed_name": "Normal",
              "type": "Milk" ]
        ]
        let firebaseMenuItems = [
            [ "name": "foo",
              "detailed_name": "Normal",
              "type": "Drink",
              "variants": firebaseItemVariants]
        ]

        let actualMenuItems = firebase.parseMenuItems(rawValue: firebaseMenuItems)

        XCTAssertEqual(expectedMenuItems, actualMenuItems)
    }
}
