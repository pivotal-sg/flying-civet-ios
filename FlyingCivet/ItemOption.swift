import Foundation

extension ItemOption: Equatable {
}

func ==(lhs: ItemOption, rhs: ItemOption) -> Bool {
    return lhs.name == rhs.name
        && lhs.selected == rhs.selected
}

struct ItemOption {
    var name: String
    var selected: Bool
}
