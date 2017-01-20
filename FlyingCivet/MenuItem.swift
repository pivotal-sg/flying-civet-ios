import Foundation

extension MenuItem: Equatable {
}

func ==(lhs: MenuItem, rhs: MenuItem) -> Bool {
    return lhs.name == rhs.name
        && lhs.type == rhs.type
        && lhs.variants == rhs.variants

}

enum ItemType: String {
    case Drink, Toast
}

struct MenuItem {
    var name: String
    var type: ItemType
    var variants: [ItemVariant]

    func hasVariants() -> Bool {
        return variants.count > 0
    }
}


