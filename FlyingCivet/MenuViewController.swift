import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    var location: String!

    typealias MenuGroup = [String: AnyObject]
    var menu = [MenuGroup]()

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self

        var menuGroup = MenuGroup()
        menuGroup["title"] = "Drinks" as AnyObject
        menuGroup["items"] = ["Kopi (Coffee)", "Teh (Tea)", "Yuanyang (Half Coffee, Half Tea)"] as AnyObject

        menu.append(menuGroup)

        menuGroup = MenuGroup()
        menuGroup["title"] = "Toasts" as AnyObject
        menuGroup["items"] = ["Kaya Toast", "Butter Sugar Toast", "Peanut Butter Toast"] as AnyObject

        menu.append(menuGroup)

        locationLabel.text = "What would you like from \(location!)?"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = getMenuItem(section: indexPath.section, row: indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items: [String] = getMenuGroup(section: section)["items"] as! [String]
        return items.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getMenuGroup(section: section)["title"]?.uppercased
    }

    func getMenuGroup(section: Int) -> MenuGroup {
        return menu[section] as MenuGroup
    }

    func getMenuItem(section: Int, row: Int) -> String {
        let menuGroup = getMenuGroup(section: section)
        let items: [String] = menuGroup["items"] as! [String]
        return items[row]
    }
}
