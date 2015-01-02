import UIKit

class TermsController: UIViewController {

    @IBOutlet var controlSegment: UISegmentedControl!
    @IBOutlet var text: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }

}
