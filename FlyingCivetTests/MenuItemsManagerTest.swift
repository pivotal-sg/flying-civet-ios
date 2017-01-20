import XCTest

class MenuItemsManagerTest: XCTestCase {
    let DEFAULT_MILK_VARIANT = ItemVariant(name: "fake-item-variant", type: .Milk)

    func testGetMenuItem() {
        let fooMenuItem = makeMenuItem(name: "foo", type: .Drink)
        let MENU_ITEMS = [
            fooMenuItem
        ]
        let MENU_DATA_SOURCE = MenuDataSource(items: MENU_ITEMS)

        let foo = MenuItemsManager(dataSource: MENU_DATA_SOURCE)
        let fooIndexPath = IndexPath(row: 0, section: 0)

        let actualFooMenuItem = foo.getMenuItem(indexPath: fooIndexPath)
        XCTAssertEqual(fooMenuItem, actualFooMenuItem)
    }

    func testGetMenuItems_byType() {
        let fooMenuItem = makeMenuItem(name: "foo", type: .Drink)
        let MENU_ITEMS = [
            fooMenuItem,
            makeMenuItem(name: "fake-kaya-toast", type: .Toast)
        ]
        let MENU_DATA_SOURCE = MenuDataSource(items: MENU_ITEMS)

        let foo = MenuItemsManager(dataSource: MENU_DATA_SOURCE)

        let actualMenuItems = foo.getMenuItems(type: .Drink)
        XCTAssertEqual([fooMenuItem], actualMenuItems)
    }

    func testNumberOfItems() {
        let MENU_ITEMS = [
            makeMenuItem(name: "kaya-toast", type: .Toast),
            makeMenuItem(name: "another-kaya-toast", type: .Toast),
            makeMenuItem(name: "coffee", type: .Drink)
        ]

        let MENU_DATA_SOURCE = MenuDataSource(items: MENU_ITEMS)
        let foo = MenuItemsManager(dataSource: MENU_DATA_SOURCE)

        let actualNumberOfItems = foo.numberOfItems(section: 0)
        XCTAssertEqual(actualNumberOfItems, 2)
    }

    func testGetMenuType() {
        let MENU_ITEMS = [
            makeMenuItem(name: "kaya-toast", type: .Toast),
            makeMenuItem(name: "coffee", type: .Drink)
        ]

        let MENU_DATA_SOURCE = MenuDataSource(items: MENU_ITEMS)
        let foo = MenuItemsManager(dataSource: MENU_DATA_SOURCE)

        let toastMenuType = foo.getMenuType(section: 0)
        XCTAssertEqual(.Toast, toastMenuType)
        let drinkMenuType = foo.getMenuType(section: 1)
        XCTAssertEqual(.Drink, drinkMenuType)
    }

    private func makeMenuItem(name: String, type: ItemType) -> MenuItem {
        return MenuItem(name: name, type: type, variants: [DEFAULT_MILK_VARIANT])
    }
}
