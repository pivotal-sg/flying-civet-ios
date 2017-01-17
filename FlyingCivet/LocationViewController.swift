import UIKit

class LocationViewController: UIViewController {

    @IBOutlet var locations: [UIButton]!
    @IBOutlet var checkmarks: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func locationSelected(_ sender: UIButton) {
        checkmarks.forEach { $0.alpha = $0.tag == sender.tag ? 1 : 0 }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedCheckmark = checkmarks.filter { $0.alpha == 1 }.first!
        let selectedLocation = locations.filter { $0.tag == selectedCheckmark.tag }.first!

        let runController: RunViewController = segue.destination as! RunViewController
        let locationText = selectedLocation.titleLabel?.text
        runController.location = locationText!
    }
}
