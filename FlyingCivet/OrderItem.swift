import Foundation

extension OrderItem: Equatable {
}

func ==(lhs: OrderItem, rhs: OrderItem) -> Bool {
    return lhs.item == rhs.item
        && lhs.itemOptions == rhs.itemOptions
        && lhs.quantity == rhs.quantity
}

struct OrderItem {
    var item: MenuItem
    var itemOptions: [ItemOption]
    var quantity: Int
}
