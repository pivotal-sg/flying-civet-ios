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

    init(name: String, type: ItemType) {
        self.name = name
        self.type = type
        self.variants = [ItemVariant]()
    }

    init(name: String, type: ItemType, variants: [ItemVariant]) {
        self.name = name
        self.type = type
        self.variants = variants
    }

    // TODO
    init(rawValue: Dictionary<String, Any>) {
        self.name = rawValue["name"]! as! String
        self.type = ItemType(rawValue: rawValue["type"]! as! String)!
        self.variants = []
    }
}


