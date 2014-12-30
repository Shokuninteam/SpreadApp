import UIKit

class StartPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var returnValue: NSString? = NSUserDefaults.standardUserDefaults().objectForKey("userId") as? NSString
        if returnValue != nil {
            performSegueWithIdentifier("DirectLoginSegue", sender: self)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
