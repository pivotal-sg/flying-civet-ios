import Foundation
import Dollar
import UIKit

class MenuControllerAdapter {
    var groups = [Group]()
    var orders = [OrderItem]()

    let RECENT_ORDERS_GROUP: OrderGroup!

    init() {
        RECENT_ORDERS_GROUP = OrderGroup(name: "Recent Orders", items: [])
        add(group: RECENT_ORDERS_GROUP)
    }

    func add(group: Group) {
        groups.append(group)
    }

    func add(order: OrderItem) {
        let EXISTING_ORDER = $.find(orders) {
            $0.item == order.item && $0.variants == order.variants
        }

        if let EXISTING_ORDER = EXISTING_ORDER {
            let EXISTING_ORDER_INDEX = orders.index(of: EXISTING_ORDER)!
            orders[EXISTING_ORDER_INDEX] = order.merge(with: EXISTING_ORDER)
        } else {
            orders.append(order)
        }

        RECENT_ORDERS_GROUP.items = orders.filter { $0.hasVariants() }
    }

    func add(name: ItemType, items: [MenuItem]) {
        let group = MenuGroup(name: name.rawValue, items: items)
        add(group: group)
    }

    func numberOfItems(section: Int) -> Int {
        return groups[section].count()
    }

    func numberOfSections() -> Int {
        return groups.count
    }

    func titleForHeaderInSection(section: Int) -> String {
        return groups[section].name
    }

    private func getItem(indexPath: IndexPath) -> Presenter {
        return groups[indexPath.section]
            .getItem(row: indexPath.row)
    }

    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let item = getItem(indexPath: indexPath)
        let existingOrder = $.find(orders) { !$0.hasVariants() && $0.item.detailedName == item.name }

        return groups[indexPath.section].cellForRowAt(
            tableView: tableView,
            indexPath: indexPath,
            quantity: existingOrder == nil ? 0 : (existingOrder?.quantity)!)
    }

    func didSelectRowAt(indexPath: IndexPath, callback: ITEM_CALLBACK) {
        groups[indexPath.section]
            .didSelectRowAt(indexPath: indexPath) {
                callback($0)
        }
    }
}
