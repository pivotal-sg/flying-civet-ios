import XCTest

class OrderItemTest: XCTestCase {

    func testEquals() {
        let foo = OrderItem(
            item: buildMenuItem(),
            variants: [],
            quantity: 3)

        let bar = OrderItem(
            item: buildMenuItem(),
            variants: [],
            quantity: 3)

        XCTAssertTrue(foo == bar)
    }

    func testEquals_withVariants() {
        let foo = OrderItem(
            item: buildMenuItem(),
            variants: buildVariants(),
            quantity: 3)

        let bar = OrderItem(
            item: buildMenuItem(),
            variants: buildVariants(),
            quantity: 3)

        XCTAssertTrue(foo == bar)
    }

    func testEquals_notEquals() {
        let foo = OrderItem(
            item: buildMenuItem(),
            variants: [],
            quantity: 3)

        let bar = OrderItem(
            item: buildMenuItem(),
            variants: [],
            quantity: 1)

        XCTAssertFalse(foo == bar)
    }

    private func buildMenuItem() -> MenuItem {
        return MenuItem(name: "foo", type: ItemType.drink, variants: buildVariants())
    }

    private func buildVariants() -> [ItemVariant] {
        let variants = [
            ItemVariant(name: "foo", type: ItemVariantType.Milk),
            ItemVariant(name: "bar", type: ItemVariantType.Temperature),
            ]
        return variants
    }
}
