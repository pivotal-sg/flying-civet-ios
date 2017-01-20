import Foundation

class MenuItemsManager {
    let menuItems: [MenuItem]
    let itemTypes: [ItemType]

    init(menuItems: [MenuItem]) {
        self.menuItems = menuItems
        self.itemTypes = Array(Set(menuItems.map { $0.type }))
    }

    func getMenuItem(indexPath: IndexPath) -> MenuItem {
        return getMenuItemsFor(section: indexPath.section)[indexPath.row]
    }

    func getMenuItemsFor(section: Int) -> [MenuItem] {
        return menuItems.filter{ $0.type == getItemType(section: section) }
    }

    func getItemType(section: Int) -> ItemType {
        return itemTypes[section]
    }
}
