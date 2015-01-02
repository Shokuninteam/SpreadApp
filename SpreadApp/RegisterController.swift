import UIKit
import CoreLocation

class RegisterController: UIViewController, RegisterRequestDelegate, CLLocationManagerDelegate {

    @IBOutlet var nickname: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var pwd: UITextField!
    @IBOutlet var female: UILabel!
    @IBOutlet var male: UILabel!
    
    let requestsServices = RequestsServices()
    let locationManager = CLLocationManager()
    var currentGender = "none"
    var location = false
    var overlayView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestsServices.registerControllerDelegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
        addBorders(nickname)
        addBorders(email)
        addBorders(pwd)
        var maleTapGesture = UITapGestureRecognizer(target: self, action: "maleClick")
        male.addGestureRecognizer(maleTapGesture)
        var femaleTapGesture = UITapGestureRecognizer(target: self, action: "femaleClick")
        female.addGestureRecognizer(femaleTapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                var label = UILabel(frame: CGRect(x: vibrancyView.frame.size.width / 2 - 75, y: vibrancyView.frame.size.height / 2 - 100, width: 150, height: 100))
                label.textAlignment = NSTextAlignment.Center
                label.text = "Registering"
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
    
    func addBorders (view : UIView){
        var border = CALayer()
        var width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: view.frame.size.height - width, width:  view.frame.size.width, height: view.frame.size.height)
        
        border.borderWidth = width
        view.layer.addSublayer(border)
        view.layer.masksToBounds = true
    }
    
    func maleClick (){
        self.currentGender = "male"
        male.textColor = UIColor(red: 0, green: 140.0/255, blue: 121.0/255, alpha: 1)
        female.textColor = UIColor.lightGrayColor()

    }

    func femaleClick (){
        self.currentGender = "female"
        female.textColor = UIColor(red: 0, green: 140.0/255, blue: 121.0/255, alpha: 1)
        male.textColor = UIColor.lightGrayColor()
    }
    
    func formCheck () -> Bool{
        var msg = ""
        var error = false
        var location = locationManager.location
        
        if (nickname.text == ""){
            msg = "Missing nickname"
            error = true
        }
        else if (email.text == ""){
            msg = "Missing email"
            error = true
        }
        else if (pwd.text == ""){
            msg = "Missing pwd"
            error = true
        }
        else if (countElements(pwd.text) < 6){
            msg = "Your password should contain at least 6 caracters"
            error = true
        }
        else if (currentGender == "none"){
            msg = "Missing Gender"
            error = true
        }
        else if (self.location == false || location == nil){
            msg = "Spread is location based, you can't use this App without localisation"
            error = true
        }
        
        if error {
            var alert = UIAlertController(title: "Register", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        return !error
    }
    
    @IBAction func register(sender: UIButton) {
        if (formCheck()){
            background()
            var location = locationManager.location
            if location != nil {
                var lat = locationManager.location.coordinate.latitude
                var long = locationManager.location.coordinate.longitude
                
                requestsServices.register(nickname.text, mail: email.text, pwd: pwd.text, gender: currentGender, long: long, lat: lat)
            }
        }
    }
    
    func registerRequestHandler(code : Int, id : String){
        self.overlayView?.hidden = true
        var msg = ""
        if (code == 201 && id != "") {
            NSUserDefaults.standardUserDefaults().setObject(id, forKey: "userId")
            NSUserDefaults.standardUserDefaults().synchronize()
            performSegueWithIdentifier("SignUpSegue", sender: self)
        } else if (code == 409){
            msg = "A conflict occured while trying to register."
        } else {
            msg = "Aa error occured while trying to register."
        }
        if (code != 201){
            var alert = UIAlertController(title: "Register", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        location = true
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        location = false
    }
}
