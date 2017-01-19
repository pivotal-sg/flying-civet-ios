import UIKit

protocol MenuDelegate {
    func addToBasket(orderItem: OrderItem)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuDelegate {

    var location: String!

    var menu = [MenuGroup]()
    var shoppingCart = ShoppingCartManager()

    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var basketLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self

        let typesOfDrinks = [
            MenuItem(name: "Kopi (Coffee)", options: availableDrinkOptions()),
            MenuItem(name: "Teh (Tea)", options: availableDrinkOptions()),
            MenuItem(name: "Yuanyang (Half Coffee, Half Tea)", options: [])
        ]
        let drinks = MenuGroup(type: "Drinks", menuItems: typesOfDrinks)

        let typesOfToasts = [
            MenuItem(name: "Kaya Toast", options: []),
            MenuItem(name: "Butter Sugar Toast", options: []),
            MenuItem(name: "Peanut Butter Toast", options: [])
        ]
        let toasts = MenuGroup(type: "Toasts", menuItems: typesOfToasts)

        menu = [drinks, toasts]

        locationLabel.text = "What would you like from \(location!)?"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let basketCount = shoppingCart.count()
        basketLabel.text = "\(basketCount)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        let currentMenuItem = getMenuItem(indexPath: indexPath)

        let count = shoppingCart.count(of: currentMenuItem)
        cell.textLabel?.text = count > 0 ? "\(count)X" : ""
        cell.detailTextLabel?.text = currentMenuItem.name

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMenuGroup(section: section).menuItems.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getMenuGroup(section: section).type.uppercased()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMenuItem = getMenuItem(indexPath: indexPath)

        if selectedMenuItem.hasVariants() {
            performSegue(withIdentifier: "showCustomizItemScreen", sender: self)
        } else {
            shoppingCart.addToCart(item: selectedMenuItem)
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! UINavigationController
        let customizeItemController: CustomizeItemViewController = destinationController.topViewController as! CustomizeItemViewController
        customizeItemController.menuItem = getMenuItem(indexPath: menuTable.indexPathForSelectedRow!)
        customizeItemController.menuDelegate = self
    }

    func getMenuGroup(section: Int) -> MenuGroup {
        return menu[section] as MenuGroup
    }

    func getMenuItem(indexPath: IndexPath) -> MenuItem {
        let menuGroup = getMenuGroup(section: indexPath.section)
        return menuGroup.menuItems[indexPath.row]
    }

    func addToBasket(orderItem: OrderItem) {
        shoppingCart.addToCart(item: orderItem)
    }

    private func availableDrinkOptions() -> [ItemOptionGroup] {
        let milkItemOptions = [
            ItemOption(name: "Normal", selected: true),
            ItemOption(name: "C (Evaporated)", selected: false),
            ItemOption(name: "O (Black)", selected: false)
        ]

        let milkItemOptionGroup = ItemOptionGroup(type: "Milk", itemOptions: milkItemOptions)

        let strengthItemOptions = [
            ItemOption(name: "Normal", selected: true),
            ItemOption(name: "Gau (Extra Strong)", selected: false),
            ItemOption(name: "Poh (Less Strong)", selected: false)
        ]

        let strengthItemOptionGroup = ItemOptionGroup(type: "Strength", itemOptions: strengthItemOptions)

        let sweetnessItemOptions = [
            ItemOption(name: "Normal", selected: true),
            ItemOption(name: "Gah Dai (Extra Sweet)", selected: false),
            ItemOption(name: "Siew Dai (Less Sweet)", selected: false),
            ItemOption(name: "Kosong (Unsweetened)", selected: false)
        ]

        let sweetnessItemOptionGroup = ItemOptionGroup(type: "Sweetness", itemOptions: sweetnessItemOptions)

        let temperatureItemOptions = [
            ItemOption(name: "Hot", selected: true),
            ItemOption(name: "Peng (Iced)", selected: false)
        ]

        let temperatureItemOptionGroup = ItemOptionGroup(type: "Temperature", itemOptions: temperatureItemOptions)
        
        return [milkItemOptionGroup, strengthItemOptionGroup, sweetnessItemOptionGroup, temperatureItemOptionGroup]
    }
}
