import XCTest

class ItemOptionsManagerTest: XCTestCase {
    func makeOptionGroup(type: String, _ itemOptions: ItemOption...) -> [ItemOptionGroup] {
        return [ItemOptionGroup(type: type, itemOptions: itemOptions)]
    }

    func testDidSelectItemOptionAt() {
        let itemOptionGroups = makeOptionGroup(
            type: "foo",
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
            type: "foo",
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

    func testReturnSelectedItemOptions() {
        let itemOptionGroup1 = makeOptionGroup(
            type: "group 1",
            ItemOption(name: "Foo", selected: true),
            ItemOption(name: "Bar", selected: false),
            ItemOption(name: "Baz", selected: false)
        )
        let itemOptionGroup2 = makeOptionGroup(
            type: "group 2",
            ItemOption(name: "Hoge", selected: false),
            ItemOption(name: "Fuge", selected: false),
            ItemOption(name: "Piyo", selected: true)
        )
        let itemManager = ItemOptionsManager(options: itemOptionGroup1 + itemOptionGroup2)

        let expectedOptions = [
            ItemOption(name: "Foo", selected: true),
            ItemOption(name: "Piyo", selected: true)
        ]

        let actualOptions = itemManager.getSelectedItemOptions()

        XCTAssertEqual(expectedOptions, actualOptions)
    }

    func testReturnSelectedItemOptions_removeNormalOptions() {
        let itemOptionGroup1 = makeOptionGroup(
            type: "group 1",
            ItemOption(name: "Normal", selected: true)
        )
        let itemOptionGroup2 = makeOptionGroup(
            type: "group 2",
            ItemOption(name: "Piyo", selected: true)
        )
        let itemManager = ItemOptionsManager(
            options: itemOptionGroup1 + itemOptionGroup2)

        let expectedOptions = [
            ItemOption(name: "Piyo", selected: true)
        ]

        let actualOptions = itemManager.getSelectedItemOptions()

        XCTAssertEqual(expectedOptions, actualOptions)
    }
}
