import UIKit

class RunViewController: UIViewController {
    var location: String!

    @IBOutlet weak var locationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text = "You are going on a Kopi Run to \(location!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }    
}
