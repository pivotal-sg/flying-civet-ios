import XCTest

class MenuDataSourceTest: XCTestCase {
    let DEFAULT_MILK_VARIANT = ItemVariant(name: "fake-item-variant", type: .Milk)

    func testGetMenuItems() {
        let expectedMenuItems = [
            makeMenuItem(name: "foo", type: .Drink)
        ]

        let dataSource = MenuDataSource(items: expectedMenuItems)

        let actualMenuItems = dataSource.getMenuItems()
        XCTAssertEqual(expectedMenuItems, actualMenuItems)
    }

    private func makeMenuItem(name: String, type: ItemType) -> MenuItem {
        return MenuItem(name: name, type: type, variants: [DEFAULT_MILK_VARIANT])
    }
}
