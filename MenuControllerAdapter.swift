import Foundation
import UIKit

class MenuControllerAdapter {
    var groups = [Group]()
    var orders = [OrderItem]()

    func add(group: Group) {
        groups.append(group)
    }

    func add(order: OrderItem) {
        orders.append(order)
        if (order.variants.count != 0) {
            let orderGroup = groups.filter{ type(of: $0) == OrderGroup.self }.first as! OrderGroup
            orderGroup.addOrder(order: order)
        }
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

    func countThings() -> Int {
        return orders.reduce(0) { $0 + $1.quantity }
    }

    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let foo = getItem(indexPath: indexPath)

        if (foo.subtitle == nil) {
            let quantity = orders.filter{ $0.variants.count == 0 && $0.item.detailedName == foo.name }.count
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell

            cell.quantityLabel.text = quantity > 0 ? "\(quantity)x" : ""
            cell.nameLabel.text = foo.name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
            cell.quantityLabel.text = "\(foo.quantity!)x"
            cell.nameLabel.text = foo.name
            cell.subtitleLabel.text = foo.subtitle
            return cell
        }
    }

    func didSelectRowAt(indexPath: IndexPath, callback: MENU_ITEM_CALLBACK) {
        groups[indexPath.section]
            .didSelectRowAt(indexPath: indexPath) {
                callback($0)
        }
    }
}
