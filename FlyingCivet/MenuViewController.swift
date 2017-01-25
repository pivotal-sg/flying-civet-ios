import UIKit

protocol MenuDelegate {
    func addToBasket(orderItem: OrderItem)
}

class Presenter {
    let subtitle: String?
    let name: String?
    let quantity: String?

    init(item: OrderItem) {
        self.subtitle = item.variants.map { $0.name }.joined(separator: " ")
        self.name = item.item.name
        self.quantity = item.quantity.description    }

    init(item: MenuItem) {
        self.name = item.detailedName
        self.quantity = nil
        self.subtitle = nil
    }
}
class MenuAdapter {
    var groups = [Group]()
    var orders = [OrderItem]()

    func add(group: Group) {
        groups.append(group)
    }

    func add(order: OrderItem) {
        orders.append(order)
    }

    func numberOfItems(section: Int) -> Int {
        return groups[section].count()
    }

    func numberOfSections() -> Int {
        return groups.count
    }

    func titleForHeaderInSection(section: Int) -> String {
        return groups[section].name
    }

    private func getItem(indexPath: IndexPath) -> Presenter {
        return groups[indexPath.section]
            .getItem(row: indexPath.row)
    }

    func countThings() -> Int {
        return orders.reduce(0) { $0 + $1.quantity }
    }

    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)

        // TODO cleanup!
        let foo = getItem(indexPath: indexPath)


        let quantity = orders.filter{ $0.item.detailedName == foo.name }.count


        // TODO show x
        cell.textLabel?.text = String(quantity) // TODO FIX THIS!
        cell.detailTextLabel?.text = foo.name

        return cell
    }

    func didSelectRowAt(indexPath: IndexPath, callback: MENU_ITEM_CALLBACK) {
        groups[indexPath.section]
            .didSelectRowAt(indexPath: indexPath) {
                callback($0)
        }
    }
}

typealias MENU_ITEM_CALLBACK = (MenuItem) -> ()

protocol Group {
    var name: String { get }
    var items: [MenuItem] { get set }

    func count() -> Int

    func getItem(row: Int) -> Presenter

    func didSelectRowAt(indexPath: IndexPath, callback: MENU_ITEM_CALLBACK)
}

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

//class OrderGroup: Group {
//    var name: String
//    var items: [OrderItem]
//
//    init(name: String, items: [OrderItem]) {
//        self.name = name
//        self.items = items
//    }
//    func count() -> Int {
//        return items.count
//    }
//
//    func getItem(row: Int) -> Presenter {
//        return Presenter(item: items[row])
//    }
//
//    func didSelectRowAt(_ view: UIViewController, indexPath: IndexPath) {
//        // no-op
//    }
//}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuDelegate {

    var location: String!

    var shoppingCart = ShoppingCartManager()
    let firebaseDataSource = FirebaseDataSource()

    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var basketLabel: UILabel!


    let orders = [OrderItem]()

    // TODO
    var adapter = MenuAdapter()
//    var ordersGroup = Group(name: "Recent Orders", items: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self

//        adapter.add(group: ordersGroup)

        firebaseDataSource.getMenuItems { items in
            // TODO cleanup
            let drinks = MenuGroup(name: "Drinks", items: items.filter { $0.type == .Drink })
            self.adapter.add(group: drinks)
            let toasts = MenuGroup(name: "Toasts", items: items.filter { $0.type == .Toast })
            self.adapter.add(group: toasts)

            self.menuTable.reloadData()
        }

        locationLabel.text = "What would you like from \(location!)?"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return adapter.cellForRowAt(tableView: tableView, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adapter.numberOfItems(section: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return adapter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return adapter.titleForHeaderInSection(section: section).uppercased()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        adapter.didSelectRowAt(indexPath: indexPath) { item in
            if item.hasVariants() {
                self.performSegue(withIdentifier: "showCustomizeItemScreen", sender: view)
            } else {
                let NEW_ORDER_ITEM = OrderItem(item: item)
                adapter.add(order: NEW_ORDER_ITEM)
            }
        }

        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! UINavigationController
        let customizeItemController: CustomizeItemViewController = destinationController.topViewController as! CustomizeItemViewController


        // TODO
        let selectedIndexPath = menuTable.indexPathForSelectedRow!
        let group = adapter.groups[selectedIndexPath.section] as! MenuGroup
        let selectedMenuItem = group.items[selectedIndexPath.row]
        customizeItemController.menuItem = selectedMenuItem
        let itemsManager =  ItemVariantsManager(variants: selectedMenuItem.variants)
        itemsManager.chosenVariants = defaultDrinkOptions()

        customizeItemController.itemsManager = itemsManager
        customizeItemController.menuDelegate = self
    }

    func addToBasket(orderItem: OrderItem) {
        adapter.add(order: orderItem)
        menuTable.reloadData() // TODO don't use!
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // TODO fix performance
        basketLabel.text = "\(adapter.countThings())"
    }

    private func defaultDrinkOptions() -> [ItemVariant] {
        return [
            ItemVariant(name: "Normal", detailedName: "Normal", type: ItemVariantType.Milk),
            ItemVariant(name: "Normal", detailedName: "Normal", type: ItemVariantType.Strength),
            ItemVariant(name: "Normal", detailedName: "Normal", type: ItemVariantType.Sweetness),
            ItemVariant(name: "Hot", detailedName: "Hot", type: ItemVariantType.Temperature),
        ]
    }

}
