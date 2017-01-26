import UIKit
import Dollar

protocol MenuDelegate {
    func addToBasket(orderItem: OrderItem)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuDelegate {

    var location: String!

    var shoppingCart = ShoppingCartManager()
    let firebaseDataSource = FirebaseDataSource()

    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var basketLabel: UILabel!

    let orders = [OrderItem]()
    var adapter = MenuControllerAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self

        firebaseDataSource.getMenuItems { items in
            $.groupBy(items) { $0.type }
                .forEach { key, value in
                    self.adapter.add(name: key, items: value)
            }

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
            let menuItem = item as! MenuItem
            if menuItem.hasVariants() {
                self.performSegue(withIdentifier: "showCustomizeItemScreen", sender: view)
            } else {
                adapter.add(order: OrderItem(item: menuItem))
            }
        }
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showCustomizeItemScreen":
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
        case "showBasketScreen":
            let basketController = segue.destination as! BasketViewController
            basketController.orders = adapter.orders
        default:
            break
        }
    }

    func addToBasket(orderItem: OrderItem) {
        adapter.add(order: orderItem)
        menuTable.reloadData() // TODO don't use!
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let TOTAL_ITEMS_ORDERED = adapter.orders.reduce(0) { $0 + $1.quantity }
        basketLabel.text = "\(TOTAL_ITEMS_ORDERED)"
    }

    // TODO
    private func defaultDrinkOptions() -> [ItemVariant] {
        return [
            ItemVariant(name: "Normal", detailedName: "Normal", type: ItemVariantType.Milk),
            ItemVariant(name: "Normal", detailedName: "Normal", type: ItemVariantType.Strength),
            ItemVariant(name: "Normal", detailedName: "Normal", type: ItemVariantType.Sweetness),
            ItemVariant(name: "Hot", detailedName: "Hot", type: ItemVariantType.Temperature),
        ]
    }

}
