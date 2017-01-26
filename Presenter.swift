import Foundation

class Presenter {
    static let IGNORE_VARIANT = "Normal"
    let subtitle: String?
    let name: String?
    let quantity: Int?

    init(item: OrderItem) {
        self.name = item.item.name
        self.quantity = item.quantity

        let combinedVariants = item.variants
            .map { $0.name }
            .filter { $0 != Presenter.IGNORE_VARIANT }
            .joined(separator: " ")

        self.subtitle = combinedVariants == "" ? "Traditional" : combinedVariants
    }

    init(item: MenuItem) {
        self.name = item.detailedName
        self.subtitle = nil
        self.quantity = nil
    }
}
