import Foundation

extension MenuItem: Equatable {
}

func ==(lhs: MenuItem, rhs: MenuItem) -> Bool {
    return lhs.name == rhs.name
        && lhs.options == rhs.options
}

struct MenuItem {
    var name: String
    var options: [ItemOptionGroup]

    func hasVariants() -> Bool {
        return options.count > 0
    }

}
