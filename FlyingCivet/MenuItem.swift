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
    var detailedName: String
    var type: ItemType
    var variants: [ItemVariant]

    func hasVariants() -> Bool {
        return variants.count > 0
    }

    init(name: String, type: ItemType) {
        self.name = name
        self.detailedName = name
        self.type = type
        self.variants = [ItemVariant]()
    }

    init(name: String, detailedName: String, type: ItemType, variants: [ItemVariant]) {
        self.name = name
        self.detailedName = detailedName
        self.type = type
        self.variants = variants
    }

    init(rawValue: Dictionary<String, Any>) {
        self.name = rawValue["name"]! as! String
        self.detailedName = rawValue["detailed_name"]! as! String
        self.type = ItemType(rawValue: rawValue["type"]! as! String)!

        guard let variants = rawValue["variants"] else {
            self.variants = []
            return
        }

        self.variants = (variants as! NSArray)
            .map { return $0 as! Dictionary<String, String> }
            .map {
                let itemVariantName = $0["name"]!
                let itemVariantDetailedName = $0["detailed_name"]!
                let itemVariantType = ItemVariantType(rawValue: $0["type"]!)!
                return (itemVariantName, itemVariantDetailedName, itemVariantType)
            }
            .map { return ItemVariant(name: $0, detailedName: $1, type: $2) }
    }
}


