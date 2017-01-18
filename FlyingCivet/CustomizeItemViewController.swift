import UIKit

class CustomizeItemViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct ItemOption {
        var name: String
    }

    struct ItemOptionGroup {
        var type: String
        var itemOptions: [ItemOption]
    }

    var menuItem: String!
    var options = [ItemOptionGroup]()

    @IBOutlet weak var customizeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let itemOptions = [
            ItemOption(name: "Normal (Condensed)"),
            ItemOption(name: "C (Evaporated)"),
            ItemOption(name: "O (Black)")
        ]

        let itemOptionGroup = ItemOptionGroup(type: "Milk", itemOptions: itemOptions)
        options.append(itemOptionGroup)

        customizeLabel.text = "How would you like your \(menuItem!)?"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemGroupCell", for: indexPath)
        let itemOption = getItemOption(section: indexPath.section, row: indexPath.row)
        cell.textLabel?.text = itemOption.name

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getItemOptionGroup(section: section).itemOptions.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getItemOptionGroup(section: section).type.uppercased()
    }

    func getItemOptionGroup(section: Int) -> ItemOptionGroup {
        return options[section] as ItemOptionGroup
    }

    func getItemOption(section: Int, row: Int) -> ItemOption {
        return getItemOptionGroup(section: section).itemOptions[row]
    }

}
