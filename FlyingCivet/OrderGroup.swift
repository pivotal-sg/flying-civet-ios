import Foundation

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

    func didSelectRowAt(indexPath: IndexPath, callback: MENU_ITEM_CALLBACK) {
        // no op
    }
}
