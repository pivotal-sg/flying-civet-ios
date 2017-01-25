import Foundation

class Presenter {
    let subtitle: String?
    let name: String?
    let quantity: Int?

    init(item: OrderItem) {
        self.name = item.item.name
        self.subtitle = item.variants.map { $0.name }.joined(separator: " ")
        self.quantity = item.quantity
    }

    init(item: MenuItem) {
        self.name = item.detailedName
        self.subtitle = nil
        self.quantity = nil
    }
}
