import UIKit

protocol MenuDelegate {
    func addToBasket(orderItem: OrderItem)
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
        let currentMenuItem = getMenuItem(indexPath: indexPath)

        let count = shoppingCart.count(of: currentMenuItem)
        cell.textLabel?.text = count > 0 ? "\(count)x" : ""
        cell.detailTextLabel?.text = currentMenuItem.name

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

    private func availableDrinkOptions() -> [ItemVariant] {
        let MilkItemVariants = [
            ItemVariant(name: "Normal", type: ItemVariantType.Milk),
            ItemVariant(name: "C (Evaporated)", type: ItemVariantType.Milk),
            ItemVariant(name: "O (Black)", type: ItemVariantType.Milk)
        ]

        let StrengthItemVariants = [
            ItemVariant(name: "Normal", type: ItemVariantType.Strength),
            ItemVariant(name: "Gau (Extra Strong)", type: ItemVariantType.Strength),
            ItemVariant(name: "Poh (Less Strong)", type: ItemVariantType.Strength)
        ]

        let SweetnessItemVariants = [
            ItemVariant(name: "Normal", type: ItemVariantType.Sweetness),
            ItemVariant(name: "Gah Dai (Extra Sweet)", type: ItemVariantType.Sweetness),
            ItemVariant(name: "Siew Dai (Less Sweet)", type: ItemVariantType.Sweetness),
            ItemVariant(name: "Kosong (Unsweetened)", type: ItemVariantType.Sweetness)
        ]

        let TemperatureItemVariants = [
            ItemVariant(name: "Hot", type: ItemVariantType.Temperature),
            ItemVariant(name: "Peng (Iced)", type: ItemVariantType.Temperature)
        ]

        return MilkItemVariants + StrengthItemVariants + SweetnessItemVariants + TemperatureItemVariants
    }

    private func defaultDrinkOptions() -> [ItemVariant] {
        return [
            ItemVariant(name: "Normal", type: ItemVariantType.Milk),
            ItemVariant(name: "Normal", type: ItemVariantType.Strength),
            ItemVariant(name: "Normal", type: ItemVariantType.Sweetness),
            ItemVariant(name: "Hot", type: ItemVariantType.Temperature),
        ]
    }

}
