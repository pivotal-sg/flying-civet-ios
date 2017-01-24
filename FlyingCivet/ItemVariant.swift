import Foundation

extension ItemVariant: Equatable {
}

func ==(lhs: ItemVariant, rhs: ItemVariant) -> Bool {
    return lhs.name == rhs.name
        && lhs.type == rhs.type
}

enum ItemVariantType: String {
    case Milk, Strength, Sweetness, Temperature
}

struct ItemVariant {
    var name: String
    var detailedName: String
    var type: ItemVariantType
}
