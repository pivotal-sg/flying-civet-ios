import Foundation

class MenuDataSource {
    let items: [MenuItem]!

    init(items: [MenuItem]) {
        self.items = items
    }

    func getMenuItems() -> [MenuItem] {
        return items
    }
}
