import Foundation

extension OrderItem: Equatable {
}

func ==(lhs: OrderItem, rhs: OrderItem) -> Bool {
    return lhs.item == rhs.item
        && lhs.variants == rhs.variants
        && lhs.quantity == rhs.quantity
}

struct OrderItem {
    var item: MenuItem
    var variants: [ItemVariant]
    var quantity: Int
}
