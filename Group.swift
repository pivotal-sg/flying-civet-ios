import Foundation
import UIKit

typealias ITEM_CALLBACK = (AnyObject) -> ()

protocol Group {
    var name: String { get }

    func count() -> Int

    func getItem(row: Int) -> Presenter

    func didSelectRowAt(indexPath: IndexPath, callback: ITEM_CALLBACK)

    func cellForRowAt(tableView: UITableView, indexPath: IndexPath, quantity: Int) -> UITableViewCell
}
