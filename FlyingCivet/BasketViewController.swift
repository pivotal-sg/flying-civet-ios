import UIKit

class BasketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var basketTable: UITableView!

    var orders: [OrderItem]!

    override func viewDidLoad() {
        super.viewDidLoad()

        basketTable.dataSource = self
        basketTable.delegate = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = orders[indexPath.row]
        let presenter = Presenter(item: item)
        let cell = Bundle.main.loadNibNamed("OrderCell", owner: tableView, options: nil)?.first as! OrderCell

        cell.quantityLabel.text = "\(presenter.quantity!)x"
        cell.nameLabel.text = presenter.name
        cell.subtitleLabel.text = presenter.subtitle
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
}
