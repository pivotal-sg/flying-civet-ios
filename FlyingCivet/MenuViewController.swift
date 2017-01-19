import UIKit

protocol MenuDelegate {
    func addToBasket(orderItem: OrderItem)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuDelegate {

    var location: String!

    var menu = [MenuGroup]()
    var basket = [OrderItem]()

    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var basketLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self

        var menuItems = [
            MenuItem(name: "Kopi (Coffee)"),
            MenuItem(name: "Teh (Tea)"),
            MenuItem(name: "Yuanyang (Half Coffee, Half Tea)")
        ]
        var menuGroup = MenuGroup(type: "Drinks", menuItems: menuItems)
        menu.append(menuGroup)

        menuItems = [
            MenuItem(name: "Kaya Toast"),
            MenuItem(name: "Butter Sugar Toast"),
            MenuItem(name: "Peanut Butter Toast")
        ]
        menuGroup = MenuGroup(type: "Toasts", menuItems: menuItems)
        menu.append(menuGroup)

        locationLabel.text = "What would you like from \(location!)?"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        basketLabel.text = "\(basket.count)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = getMenuItem(indexPath: indexPath).name

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let customizeItemController: CustomizeItemViewController = segue.destination as! CustomizeItemViewController
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
        basket.append(orderItem)
    }
}
