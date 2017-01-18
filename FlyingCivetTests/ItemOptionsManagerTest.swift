import XCTest

class ItemOptionsManagerTest: XCTestCase {
    func makeOptionGroup(_ itemOptions: ItemOption...) -> [ItemOptionGroup] {
        return [ItemOptionGroup(type: "Foo", itemOptions: itemOptions)]
    }

    func testDidSelectItemOptionAt() {
        let itemOptionGroups = makeOptionGroup(
            ItemOption(name: "Foo", selected: false)
        )
        let itemManager = ItemOptionsManager(options: itemOptionGroups)
        let selectedIndexPath = IndexPath.init(row: 0, section: 0)

        itemManager.didSelectItemOptionAt(indexPath: selectedIndexPath)

        let expectedOptions = [
            ItemOption(name: "Foo", selected: true)
        ]
        let actualOptions = itemManager.getGroup(section: 0).itemOptions

        XCTAssertEqual(expectedOptions, actualOptions)
    }

    func testDidSelectItemOptionAt_deselectsOtherItems() {
        let itemOptionGroups = makeOptionGroup(
            ItemOption(name: "Foo", selected: true),
            ItemOption(name: "Bar", selected: false),
            ItemOption(name: "Baz", selected: false)
        )
        let itemManager = ItemOptionsManager(options: itemOptionGroups)
        let selectedIndexPath = IndexPath.init(row: 1, section: 0)

        itemManager.didSelectItemOptionAt(indexPath: selectedIndexPath)

        let expectedOptions = [
            ItemOption(name: "Foo", selected: false),
            ItemOption(name: "Bar", selected: true),
            ItemOption(name: "Baz", selected: false)
        ]

        let actualOptions = itemManager.getGroup(section: 0).itemOptions

        XCTAssertEqual(expectedOptions, actualOptions)
    }

}
