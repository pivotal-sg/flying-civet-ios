import UIKit

class CustomizeItemViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {

    var menuItem: String!

    @IBOutlet weak var customizeLabel: UILabel!
    @IBOutlet weak var customizeTable: UITableView!

    var itemsManager: ItemOptionsManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        itemsManager = ItemOptionsManager(options: customizeItemOptions())

        customizeTable.dataSource = self
        customizeTable.delegate = self

        customizeLabel.text = "How would you like your \(menuItem!)?"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemGroupCell", for: indexPath)

        let itemOption = itemsManager.getItem(indexPath: indexPath)

        cell.textLabel?.text = itemOption.name
        cell.accessoryView = itemOption.selected ? getCheckmarkView() : nil

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemsManager.didSelectItemOptionAt(indexPath: indexPath)
        tableView.reloadSections([indexPath.section], with: UITableViewRowAnimation.none)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsManager.getGroup(section: section).itemOptions.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return itemsManager.options.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return itemsManager.getGroup(section: section).type.uppercased()
    }

    private func getCheckmarkView() -> UIImageView{
        let checkmark = UIImage.init(named: "checkmark")
        let checkmarkView = UIImageView.init(image: checkmark)
        checkmarkView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        return checkmarkView
    }

    private func customizeItemOptions() -> [ItemOptionGroup] {
        let milkItemOptions = [
            ItemOption(name: "Normal (Condensed)", selected: true),
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
