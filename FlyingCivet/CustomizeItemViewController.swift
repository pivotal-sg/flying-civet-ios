import UIKit

class CustomizeItemViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {

    var menuItem: MenuItem!

    @IBOutlet weak var customizeLabel: UILabel!
    @IBOutlet weak var customizeTable: UITableView!
    @IBOutlet weak var quantityLabel: UILabel!

    var itemsManager: ItemOptionsManager!
    var menuDelegate: MenuDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        itemsManager = ItemOptionsManager(options: menuItem.options)

        customizeTable.dataSource = self
        customizeTable.delegate = self

        customizeLabel.text = "How would you like your \(menuItem.name)?"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemGroupCell", for: indexPath)

        let itemOption = itemsManager.getItem(indexPath: indexPath)

        cell.textLabel?.text = itemOption.name
        cell.accessoryView = itemOption.selected ? getCheckmarkView() : nil
        cell.isSelected = itemOption.selected

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

    @IBAction func quantityChanged(_ sender: Any) {
        let stepper: UIStepper = sender as! UIStepper
        let stepperValue = Int(stepper.value)
        quantityLabel.text = "\(stepperValue)"
    }

    @IBAction func addToBasketClicked(_ sender: Any) {
        menuDelegate.addToBasket(orderItem: makeOrderItem())
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private func makeOrderItem() -> OrderItem {
        let quantity: Int = Int(quantityLabel.text!)!
        return OrderItem(item: menuItem,
                         itemOptions: getItemOptions(),
                         quantity: quantity)
    }

    private func getItemOptions() -> [ItemOption] {
        return itemsManager.getSelectedItemOptions()
    }


    
}
