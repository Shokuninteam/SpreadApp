import UIKit

class LoginController: UIViewController, LoginRequestDelegate {
    
    var userId : String?
    var requestServices = RequestsServices()
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var pwd: UITextField!
    
    var overlayView : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        requestServices.loginControllerDelegate = self
        addBorders()
    }
    
    func addBorders (){
        var border = CALayer()
        var width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: userName.frame.size.height - width, width:  userName.frame.size.width, height: userName.frame.size.height)
        
        border.borderWidth = width
        userName.layer.addSublayer(border)
        userName.layer.masksToBounds = true
        
        var border2 = CALayer()
        border2.borderColor = UIColor.lightGrayColor().CGColor
        border2.frame = CGRect(x: 0, y: pwd.frame.size.height - width, width:  pwd.frame.size.width, height: pwd.frame.size.height)
        
        border2.borderWidth = width
        pwd.layer.addSublayer(border2)
        pwd.layer.masksToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SignIn(sender: UIButton) {
        self.background()
        requestServices.loginNickname(userName.text, pwd: pwd.text)
    }
    
    func background () {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            if (self.overlayView == nil){
                // blur view
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view.bounds
                self.overlayView=blurEffectView
                view.addSubview(blurEffectView)
            
                // vibrancy view
                var vibrancy = UIVibrancyEffect(forBlurEffect: blurEffect)
                var vibrancyView = UIVisualEffectView(effect: vibrancy)
                vibrancyView.frame = CGRect(x: 0, y: 0, width: blurEffectView.frame.size.width, height:blurEffectView.frame.size.height)
            
                // label
                var label = UILabel(frame: CGRect(x: vibrancyView.frame.size.width / 2 - 50, y: vibrancyView.frame.size.height / 2 - 100, width: 100, height: 100))
                label.textAlignment = NSTextAlignment.Center
                label.text = "Loging in"
                label.font = UIFont(name: label.font.fontName, size: 20)
                label.textColor = UIColor.grayColor()
                vibrancyView.addSubview(label)
                blurEffectView.addSubview(vibrancyView)
            
                // activity indicator
                var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                vibrancyView.addSubview(activityIndicator)
                activityIndicator.startAnimating()
            
            
                //add auto layout constraints so that the blur fills the screen upon rotating device
                blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
                view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
                view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
                view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
                view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
            } else {
                self.overlayView?.hidden = false
            }
            
        }
    }
    
    func loginRequestHandler(code : Int, id : String) {
        self.overlayView?.hidden = true
        if code == 200 {
            performSegueWithIdentifier("SignInSegue", sender: self)
            NSUserDefaults.standardUserDefaults().setObject(id, forKey: "userId")
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            var msg = "No awnser from the server"
            if code == 404 || code == 400{
                msg = "Wrong credentials"
            }
            var alert = UIAlertController(title: "Log in", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}

