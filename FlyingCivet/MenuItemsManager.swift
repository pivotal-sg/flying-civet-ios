import Foundation

class MenuItemsManager {
    var items: [MenuItem]
    var itemTypes: [ItemType]

    init(items: [MenuItem]) {
        self.items = items
        self.itemTypes = items
            .map { $0.type }
            .reduce([]) { acc, itemType in
                return acc.contains(itemType) ? acc : acc + [ itemType ]
        }
    }

    convenience init() {
        self.init(items: [])
    }

    func getMenuItem(indexPath: IndexPath) -> MenuItem {
        let selectedMenuType = getMenuType(section: indexPath.section)
        return getMenuItems(type: selectedMenuType)[indexPath.row]
    }

    func getMenuItems(type: ItemType) -> [MenuItem] {
        return items.filter { $0.type == type }
    }

    func numberOfItems(section: Int) -> Int {
        let menuType = getMenuType(section: section)
        return getMenuItems(type: menuType).count
    }

    func getMenuType(section: Int) -> ItemType {
        return itemTypes[section]
    }
}

