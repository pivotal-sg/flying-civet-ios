import Foundation
import UIKit

class OrderGroup: Group {
    var name: String
    var items: [OrderItem]

    init(name: String, items: [OrderItem]) {
        self.name = name
        self.items = items
    }

    func addOrder(order: OrderItem) {
        items.append(order)
    }

    func count() -> Int {
        return items.count
    }

    func getItem(row: Int) -> Presenter {
        return Presenter(item: items[row])
    }

    func didSelectRowAt(indexPath: IndexPath, callback: ITEM_CALLBACK) {
        // no op
    }

    func cellForRowAt(tableView: UITableView, indexPath: IndexPath, quantity: Int) -> UITableViewCell {
        let item = getItem(row: indexPath.row)
        let cell = Bundle.main.loadNibNamed("OrderCell", owner: tableView, options: nil)?.first as! OrderCell
        
        cell.quantityLabel.text = "\(item.quantity!)x"
        cell.nameLabel.text = item.name
        cell.subtitleLabel.text = item.subtitle
        return cell
    }
}
