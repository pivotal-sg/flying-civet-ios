import Foundation
import UIKit

class MenuGroup: Group {
    var name: String
    var items: [MenuItem]

    init(name: String, items: [MenuItem]) {
        self.name = name
        self.items = items
    }
    func count() -> Int {
        return items.count
    }

    func getItem(row: Int) -> Presenter {
        return Presenter(item: items[row])
    }

    func didSelectRowAt(indexPath: IndexPath, callback: ITEM_CALLBACK) {
        let item = items[indexPath.row]
        callback(item as AnyObject)
    }

    func cellForRowAt(tableView: UITableView, indexPath: IndexPath, quantity: Int) -> UITableViewCell {
        let item = getItem(row: indexPath.row)
        let cell = Bundle.main.loadNibNamed("MenuCell", owner: tableView, options: nil)?.first as! MenuCell

        cell.quantityLabel.text = quantity > 0 ? "\(quantity)x" : ""
        cell.nameLabel.text = item.name
        return cell
    }
}
