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

    func testHasVariants() {
        let orderWithoutVariants = OrderItem(item: buildMenuItem())
        let orderWithVariants = OrderItem(item: buildMenuItem(), variants: buildVariants(), quantity: 10)

        XCTAssertFalse(orderWithoutVariants.hasVariants())
        XCTAssertTrue(orderWithVariants.hasVariants())
    }

    func testMerge() {
        let order = OrderItem(item: buildMenuItem(), variants: buildVariants(), quantity: 10)
        let otherOrder = OrderItem(item: buildMenuItem(), variants: buildVariants(), quantity: 5)

        let mergedOrder = order.merge(with: otherOrder)

        XCTAssertEqual(15, mergedOrder.quantity)
        XCTAssertEqual(order.item, mergedOrder.item)
        XCTAssertEqual(order.variants, mergedOrder.variants)
    }

    private func buildMenuItem() -> MenuItem {
        return MenuItem(name: "foo", detailedName: "foo",  type: ItemType.Drink, variants: buildVariants())
    }

    private func buildVariants() -> [ItemVariant] {
        let variants = [
            ItemVariant(name: "foo", detailedName: "foo",  type: ItemVariantType.Milk),
            ItemVariant(name: "bar", detailedName: "bar",  type: ItemVariantType.Temperature),
            ]
        return variants
    }
}
