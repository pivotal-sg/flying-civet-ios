import XCTest

class ItemVariantTest: XCTestCase {
    func testEquals() {
        let foo = ItemVariant(name: "foo", type: ItemVariantType.Milk)
        let bar = ItemVariant(name: "foo", type: ItemVariantType.Milk)
        XCTAssertTrue(foo == bar)
    }

    func testNotEquals() {
        let foo = ItemVariant(name: "foo", type: ItemVariantType.Milk)
        let bar = ItemVariant(name: "bar", type: ItemVariantType.Milk)
        XCTAssertTrue(foo != bar)
    }
}
