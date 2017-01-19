import Foundation

class ItemOptionsManager {
    let DEFAULT_ITEM_OPTION = "Normal"

    var options = [ItemOptionGroup]()

    init(options: [ItemOptionGroup]) {
        self.options = options
    }

    func getGroup(section: Int) -> ItemOptionGroup {
        return options[section] as ItemOptionGroup
    }

    func getItem(indexPath: IndexPath) -> ItemOption {
        return getGroup(section: indexPath.section).itemOptions[indexPath.row]
    }

    func didSelectItemOptionAt(indexPath: IndexPath) {
        let itemOptionGroup = getGroup(section: indexPath.section)
        let newItemOptions = itemOptionGroup
            .itemOptions
            .enumerated()
            .map { (index, itemOption) in
                return ItemOption(name: itemOption.name,
                                  selected: index == indexPath.row)
        }

        options[indexPath.section] = ItemOptionGroup(
            type: itemOptionGroup.type,
            itemOptions: newItemOptions)
    }

    func getSelectedItemOptions() -> [ItemOption] {
        return options
            .flatMap { $0.itemOptions }
            .filter { $0.selected }
            .filter { $0.name != DEFAULT_ITEM_OPTION }
    }
}
