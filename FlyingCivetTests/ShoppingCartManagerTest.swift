import XCTest

class ShoppingCartManagerTest: XCTestCase {

    func testAddToCart() {
        let manager = ShoppingCartManager()
        XCTAssert(manager.items.count == 0)

        let fooMenuItem = makeMenuItem(name: "Foo")
        let fooOrderItem = OrderItem(item: fooMenuItem,
                                     variants: [/* No variants*/],
                                     quantity: 3)

        manager.addToCart(item: fooOrderItem)
        XCTAssert(manager.items.count == 1)
    }

    func testAddToCart_noVariants() {
        let manager = ShoppingCartManager()
        XCTAssert(manager.items.count == 0)
        let fooMenuItem = makeMenuItem(name: "Foo")
        manager.addToCart(item: fooMenuItem)
        XCTAssert(manager.items.count == 1)
    }

    func testCount_emptyShoppingCart() {
        let manager = ShoppingCartManager()
        let fooMenuItem = makeMenuItem(name: "Foo")
        let amountOrdered = manager.count(of: fooMenuItem)
        XCTAssert(amountOrdered == 0)
    }

    func testCount() {
        let manager = ShoppingCartManager()

        let fooMenuItem = makeMenuItem(name: "Foo")
        let fooOrderItem = OrderItem(item: fooMenuItem,
                                     variants: [/* No variants*/],
                                     quantity: 3)

        manager.addToCart(item: fooOrderItem)

        let amountOrdered = manager.count(of: fooMenuItem)
        XCTAssert(amountOrdered == 3)
    }

    private func makeMenuItem(name: String) -> MenuItem {
        return MenuItem(
            name: name,
            detailedName: name,
            type: ItemType.Drink,
            variants: [/* Foo has no variants */])
    }

    func testCount_allItems() {
        let manager = ShoppingCartManager()

        let fooMenuItem = makeMenuItem(name: "Foo")
        let fooOrderItem = OrderItem(item: fooMenuItem,
                                     variants: [/* No variants*/],
                                     quantity: 3)

        manager.addToCart(item: fooOrderItem)
        manager.addToCart(item: fooOrderItem)

        XCTAssert(manager.count() == 6)
    }

}

class OrderPresenterTest: XCTestCase {
    func testPresenter() {
        let coffee = MenuItem(name: "Kopi", detailedName: "Kopi (Coffee)", type: .Drink, variants: [])
        let variants = [
            ItemVariant(name: "C", detailedName: "C (Evaporated)", type: .Milk),
            ItemVariant(name: "Kosong", detailedName: "Kosong (Unsweetened)", type: .Sweetness)
        ]

        let kopiKosong = OrderItem(item: coffee, variants: variants, quantity: 3)

        let presenter = OrderPresenter(item: kopiKosong)

        XCTAssertEqual("C Kosong", presenter.subtitle)
        XCTAssertEqual("Kopi", presenter.name)
        XCTAssertEqual("3", presenter.quantity)
    }
}
