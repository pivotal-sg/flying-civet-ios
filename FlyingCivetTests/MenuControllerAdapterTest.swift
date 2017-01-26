import XCTest

class FakeTestGroup: Group {
    var name: String = "I am a fake test group"
    var quantity: Int = 0

    func count() -> Int {
        return 3
    }

    func getItem(row: Int) -> Presenter {
        let FAKE_MENU_ITEM = MenuItem(name: "foo", type: .Drink)
        return Presenter(item: FAKE_MENU_ITEM)
    }

    func didSelectRowAt(indexPath: IndexPath, callback: ITEM_CALLBACK) {
        callback("I am an AnyObject" as AnyObject)
    }

    func cellForRowAt(tableView: UITableView, indexPath: IndexPath, quantity: Int) -> UITableViewCell {
        self.quantity = quantity
        return MenuCell()
    }
}

class MenuControllerAdapterTest: XCTestCase {

    var adapter: MenuControllerAdapter?
    let FAKE_ADAPTER_GROUP = FakeTestGroup()
    let FAKE_MENU_ITEM = MenuItem(name: "foo", type: .Drink)

    override func setUp() {
        adapter = MenuControllerAdapter()
    }

    override func tearDown() {
        adapter = nil
    }

    func testAddGroup() {
        XCTAssertEqual(1, adapter?.groups.count)
        adapter?.add(group: FAKE_ADAPTER_GROUP)
        XCTAssertEqual(2, adapter?.groups.count)
    }

    func testAddOrder() {
        XCTAssertEqual(0, adapter?.orders.count)
        let FAKE_ORDER_ITEM = OrderItem(item: FAKE_MENU_ITEM)
        adapter?.add(order: FAKE_ORDER_ITEM)
        XCTAssertEqual(1, adapter?.orders.count)
    }

    func testAddOrder_groupsOrdersWithoutVariants() {
        XCTAssertEqual(0, adapter?.orders.count)
        let FAKE_ORDER_ITEM = OrderItem(item: FAKE_MENU_ITEM)
        adapter?.add(order: FAKE_ORDER_ITEM)
        adapter?.add(order: FAKE_ORDER_ITEM)
        adapter?.add(order: FAKE_ORDER_ITEM)
        XCTAssertEqual(1, adapter?.orders.count)
        XCTAssertEqual(3, adapter?.orders[0].quantity)
    }

    func testAddOrder_groupsOrdersWithVariants() {
        let KOPI = MenuItem(name: "Kopi", type: .Drink)
        let KOSONG = ItemVariant(name: "foo", detailedName: "foo", type: .Milk)
        let KOPI_KOSONG = OrderItem(item: KOPI, variants: [KOSONG], quantity: 1)
        adapter?.add(order: KOPI_KOSONG)
        adapter?.add(order: KOPI_KOSONG)
        XCTAssertEqual(1, adapter?.orders.count)
        XCTAssertEqual(2, adapter?.orders[0].quantity)
    }

    func testAddOrder_groupsRecentOrders() {
        XCTAssertEqual(0, adapter?.orders.count)
        let KOPI = MenuItem(name: "Kopi", type: .Drink)
        let KOSONG = ItemVariant(name: "foo", detailedName: "foo", type: .Milk)
        let KOPI_KOSONG = OrderItem(item: KOPI, variants: [KOSONG], quantity: 1)
        adapter?.add(order: KOPI_KOSONG)
        adapter?.add(order: KOPI_KOSONG)
        adapter?.add(order: KOPI_KOSONG)
        XCTAssertEqual(1, adapter?.RECENT_ORDERS_GROUP.items.count)
        XCTAssertEqual(3, adapter?.RECENT_ORDERS_GROUP.items[0].quantity)
    }

    func testAddOrder_withVariants() {
        let FAKE_ITEM_VARIANT = ItemVariant(name: "foo", detailedName: "foo", type: .Milk)
        let FAKE_ORDER_ITEM = OrderItem(
            item: FAKE_MENU_ITEM,
            variants: [FAKE_ITEM_VARIANT],
            quantity: 3)
        adapter?.add(order: FAKE_ORDER_ITEM)
    }

    func testAddGroup_byNameAndItem() {
        XCTAssertEqual(1, adapter?.groups.count)
        adapter?.add(name: .Drink, items: [])
        XCTAssertEqual(2, adapter?.groups.count)
    }

    func testNumberOfItems() {
        adapter?.add(group: FAKE_ADAPTER_GROUP)

        // Hard coded value
        XCTAssertEqual(3, adapter?.numberOfItems(section: 1))
    }

    func testNumberOfSections() {
        adapter?.add(group: FAKE_ADAPTER_GROUP)
        XCTAssertEqual(2, adapter?.numberOfSections())
    }

    func testTitleForHeaderInSection() {
        adapter?.add(group: FAKE_ADAPTER_GROUP)
        let HEADER = adapter?.titleForHeaderInSection(section: 1)
        XCTAssertEqual("I am a fake test group", HEADER)
    }

    func testDidSelectRowAt() {
        adapter?.add(group: FAKE_ADAPTER_GROUP)
        let FAKE_INDEX_PATH = IndexPath(row: 0, section: 0)
        adapter?.didSelectRowAt(indexPath: FAKE_INDEX_PATH) {
            // Hard coded
            XCTAssertEqual("I am an AnyObject", $0 as! String)
        }
    }

    func testCellForRowAt() {
        let DRINK_MENU_ITEM = MenuItem(name: "foo", type: .Drink)
        let DRINK_ORDER_ITEM = OrderItem(item: DRINK_MENU_ITEM)
        adapter?.add(order: DRINK_ORDER_ITEM)
        adapter?.add(group: FAKE_ADAPTER_GROUP)
        let FAKE_TABLE_VIEW = UITableView()
        let FAKE_INDEX_PATH = IndexPath(row: 0, section: 1)
        XCTAssertEqual(0, FAKE_ADAPTER_GROUP.quantity)
        let _ = adapter?.cellForRowAt(tableView: FAKE_TABLE_VIEW, indexPath: FAKE_INDEX_PATH)
        XCTAssertEqual(1, FAKE_ADAPTER_GROUP.quantity)
    }
}
