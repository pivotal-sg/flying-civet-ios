import XCTest

class MenuItemTest: XCTestCase {
    func testEquals() {
        let foo = MenuItem(name: "foo",
                           type: ItemType.drink,
                           variants: [])
        let bar = MenuItem(name: "foo",
                           type: ItemType.drink,
                           variants: [])

        XCTAssertTrue(foo == bar)
    }

    func testEquals_withVariants() {
        let foo = MenuItem(name: "foo",
                           type: ItemType.drink,
                           variants: [
                            ItemVariant(
                                name: "foo",
                                type: ItemVariantType.Milk)])
        let bar = MenuItem(name: "foo",
                           type: ItemType.drink,
                           variants: [
                            ItemVariant(
                                name: "foo",
                                type: ItemVariantType.Milk)])

        XCTAssertTrue(foo == bar)
    }

    func testNotEquals() {
        let foo = MenuItem(name: "foo",
                           type: ItemType.drink,
                           variants: [])
        let bar = MenuItem(name: "bar",
                           type: ItemType.drink,
                           variants: [])

        XCTAssertTrue(foo != bar)
    }
}

