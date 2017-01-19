import Foundation

extension ItemOptionGroup: Equatable {
}

func ==(lhs: ItemOptionGroup, rhs: ItemOptionGroup) -> Bool {
    return lhs.type == rhs.type
        && lhs.itemOptions == rhs.itemOptions
}

struct ItemOptionGroup {
    var type: String
    var itemOptions: [ItemOption]
}
