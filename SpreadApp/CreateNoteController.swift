import UIKit
import CoreLocation

class CreateNoteController: UIViewController, CLLocationManagerDelegate, CreateNoteRequestDelegate {
    
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var content: UITextView!
    @IBOutlet var tagsLabel: UILabel!
    @IBOutlet var tags: UITextView!
    
    let requestsServices = RequestsServices()
    let locationManager = CLLocationManager()
    var location = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBorders(contentLabel)
        addBorders(tagsLabel)
        requestsServices.createNoteControllerDelegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func formCheck () -> Bool{
        var msg = ""
        var error = false
        
        if content.text == ""{
            msg = "Mising content"
            error = true
        } else if countElements(content.text) > 250 {
            msg = "The maximum length for a note is 250, yours have \(countElements(content.text)) elements"
            error = true
        } else if !location {
            msg = "Spread needs your coordinates to create a new note and spread it correctly"
            error = true
        }
        
        if error {
            var alert = UIAlertController(title: "New note", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        return !error
    }
    
    @IBAction func send(sender: AnyObject) {
        if formCheck() {
            var userId: NSString? = NSUserDefaults.standardUserDefaults().objectForKey("userId") as? NSString
            if userId != nil {
                requestsServices.createNote(content.text, tags: tags.text, user: userId!, long: locationManager.location.coordinate.longitude, lat: locationManager.location.coordinate.latitude)
            }
        }
        
    }
    
    func createNoteRequestHandler(code : Int){
        println(code)
        if code != 201 {
            var alert = UIAlertController(title: "error", message: "Unable to creante your note", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {

            
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