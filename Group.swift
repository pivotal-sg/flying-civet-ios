import Foundation

typealias MENU_ITEM_CALLBACK = (MenuItem) -> ()

protocol Group {
    var name: String { get }

    func count() -> Int

    func getItem(row: Int) -> Presenter

    func didSelectRowAt(indexPath: IndexPath, callback: MENU_ITEM_CALLBACK)
}
