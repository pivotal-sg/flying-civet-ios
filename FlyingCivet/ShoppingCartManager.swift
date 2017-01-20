import Foundation

class ShoppingCartManager {
    var items = [OrderItem]()

    func addToCart(item: OrderItem) {
        items.append(item)
    }

    func addToCart(item: MenuItem) {
        let item = OrderItem(item: item, variants: [], quantity: 1)
        items.append(item)
    }

    func count(of item: MenuItem) -> Int {
        return items
            .filter { $0.item == item }
            .reduce(0) { $0 + $1.quantity }
    }

    func getOrderedItems() -> [OrderItem] {
        return items
    }

    func count() -> Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}
