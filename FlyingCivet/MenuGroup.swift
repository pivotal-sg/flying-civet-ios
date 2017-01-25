import Foundation

class MenuGroup: Group {
    var name: String
    var items: [MenuItem]

    init(name: String, items: [MenuItem]) {
        self.name = name
        self.items = items
    }
    func count() -> Int {
        return items.count
    }

    func getItem(row: Int) -> Presenter {
        return Presenter(item: items[row])
    }

    func didSelectRowAt(indexPath: IndexPath, callback: MENU_ITEM_CALLBACK) {
        let item = items[indexPath.row]
        callback(item)
    }
}
