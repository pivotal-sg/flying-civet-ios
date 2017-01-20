import Foundation

class MenuItemsManager {
    let items: [MenuItem]!
    let itemTypes: [ItemType]!

    init(dataSource: MenuDataSource) {
        self.items = dataSource.getMenuItems()
        self.itemTypes = items
            .map { $0.type }
            .reduce([]) { acc, itemType in
                return acc.contains(itemType) ? acc : acc + [ itemType ]
        }
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
