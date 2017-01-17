import UIKit

class LocationViewController: UIViewController {

    
    @IBOutlet var checkmarks: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func locationSelected(_ sender: UIButton) {
        checkmarks.forEach { $0.alpha = 0 }
        checkmarks[sender.tag].alpha = 1
    }
}
