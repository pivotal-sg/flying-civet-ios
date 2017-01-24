import UIKit

protocol MenuDelegate {
    func addToBasket(orderItem: OrderItem)
}

class OrderPresenter {
    let subtitle: String
    let name: String
    let quantity: String

    init(item: OrderItem) {
        self.subtitle = item.variants.map { $0.name }.joined(separator: " ")
        self.name = item.item.name
        self.quantity = item.quantity.description
    }
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuDelegate {

    var location: String!

    var menuManager = MenuItemsManager()
    var shoppingCart = ShoppingCartManager()
    let firebaseDataSource = FirebaseDataSource()

    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var basketLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self

        firebaseDataSource.getMenuItems {
            self.menuManager = MenuItemsManager(items: $0)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)

        let newIndexPath = IndexPath(row: indexPath.row, section: indexPath.section)
        let currentMenuItem = getMenuItem(indexPath: newIndexPath)

        let count = shoppingCart.count(of: currentMenuItem)
        cell.textLabel?.text = count > 0 ? "\(count)x" : ""
        cell.detailTextLabel?.text = currentMenuItem.detailedName

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuManager.numberOfItems(section: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return menuManager.itemTypes.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuManager.getMenuType(section: section).rawValue
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMenuItem = getMenuItem(indexPath: indexPath)

        if selectedMenuItem.hasVariants() {
            performSegue(withIdentifier: "showCustomizeItemScreen", sender: self)
        } else {
            shoppingCart.addToCart(item: selectedMenuItem)
            updateBasketCount()
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! UINavigationController
        let customizeItemController: CustomizeItemViewController = destinationController.topViewController as! CustomizeItemViewController
        let selectedMenuItem = getMenuItem(indexPath: menuTable.indexPathForSelectedRow!)
        customizeItemController.menuItem = selectedMenuItem

        let itemsManager =  ItemVariantsManager(variants: selectedMenuItem.variants)
        itemsManager.chosenVariants = defaultDrinkOptions()

        customizeItemController.itemsManager = itemsManager
        customizeItemController.menuDelegate = self
    }

    func getMenuItem(indexPath: IndexPath) -> MenuItem {
        return menuManager.getMenuItem(indexPath: indexPath)
    }

    func addToBasket(orderItem: OrderItem) {
        shoppingCart.addToCart(item: orderItem)
        updateBasketCount()
    }

    private func updateBasketCount() {
        let basketCount = shoppingCart.count()
        basketLabel.text = "\(basketCount)"
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
