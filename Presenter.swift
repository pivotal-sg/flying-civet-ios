import Foundation

class Presenter {
    let subtitle: String?
    let name: String?
    let quantity: String?

    init(item: OrderItem) {
        self.subtitle = item.variants.map { $0.name }.joined(separator: " ")
        self.name = item.item.name
        self.quantity = item.quantity.description    }

    init(item: MenuItem) {
        self.name = item.detailedName
        self.quantity = nil
        self.subtitle = nil
    }
}
