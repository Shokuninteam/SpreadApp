import UIKit
import CoreLocation

class NewsFeedController: UIPageTargetViewController, FeedRequestDelegate, CLLocationManagerDelegate{
    
    let requestsServices = RequestsServices()
    let locationManager = CLLocationManager()
    var unansweredNotes : [Note]?
    var currentNote : Note?
    var author : User?
    var location = false
    var overlayView : UIView?
    
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var authorName: UILabel!
    @IBOutlet var spreadCount: UILabel!
    @IBOutlet var star: UIButton!
    @IBOutlet var content: UITextView!
    @IBOutlet var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.index = 1
        self.navigationItem.setHidesBackButton(true, animated: true)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.requestsServices.newsFeedControllerDelegate = self
        refreshUnansweredNotes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshUnansweredNotes (){
        var id: NSString? = NSUserDefaults.standardUserDefaults().objectForKey("userId") as? NSString
        if id != nil {
            requestsServices.getUnansweredNotes(id!)
        }
    }
    
    func feedUnansweredNotesRequestHandler(unansweredNotes : [Note]){
        self.unansweredNotes = unansweredNotes
        nextNote()
    }
    
    func feedNoteUserRquestHandler(user : User){
        self.author = user
        self.authorName.text = user.nickname
        var img = UIImage(data: user.avatar!)
        avatar.image = img
    }
    
    func displayNote (note : Note){
        requestsServices.getNoteUser(note.user!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date.text = dateFormatter.stringFromDate(note.date!)
        self.content.text = note.content
        self.spreadCount.text = "\(countElements(note.spread!))"
    }
    
    func nextNote (){
        if self.unansweredNotes != nil && self.unansweredNotes?.count > 0 {
            self.overlayView?.hidden = true
            self.currentNote = self.unansweredNotes!.removeLast() as Note
            displayNote(self.currentNote!)
        } else {
            noNotesOverlay();
        }
    }
    
    func noNotesOverlay () {
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
                var label = UILabel(frame: CGRect(x: vibrancyView.frame.size.width / 2 - 100, y: vibrancyView.frame.size.height / 2 - 100, width: 200, height: 100))
                label.textAlignment = NSTextAlignment.Center
                label.text = "Nothing new to display"
                label.font = UIFont(name: label.font.fontName, size: 14)
                label.textColor = UIColor.grayColor()
                vibrancyView.addSubview(label)
                
                // label
                var label2 = UILabel(frame: CGRect(x: vibrancyView.frame.size.width / 2 - 100, y: vibrancyView.frame.size.height / 2 - 50, width: 200, height: 100))
                label2.textAlignment = NSTextAlignment.Center
                label2.text = "<- Profil      Notes ->"
                label2.font = UIFont(name: label.font.fontName, size: 14)
                label2.textColor = UIColor.grayColor()
                vibrancyView.addSubview(label2)
                blurEffectView.addSubview(vibrancyView)
                
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
    
    func feedSpreadRequestHandler(code : Int){
        
    }
    
    func feedDiscardRequestHandler(code : Int){
        
    }
    
    func checkLocation () -> Bool{
        var location = locationManager.location
        if location != nil || self.location {
            return true
        } else {
            var msg = "Spread is location based, you can't use this App without localisation"
            var alert = UIAlertController(title: "Location", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
    }
    
    @IBAction func discard(sender: AnyObject) {
        var id: NSString? = NSUserDefaults.standardUserDefaults().objectForKey("userId") as? NSString
        if id != nil && checkLocation(){
            var location = locationManager.location
            requestsServices.discardNote(id!, noteId: self.currentNote!.id!, lat: location.coordinate.latitude, long: location.coordinate.longitude)
            nextNote()
        }
        
    }

    @IBAction func spread(sender: AnyObject) {
        var id: NSString? = NSUserDefaults.standardUserDefaults().objectForKey("userId") as? NSString
        if id != nil && checkLocation(){
            var location = locationManager.location
            requestsServices.spreadNote(id!, noteId: self.currentNote!.id!, lat: location.coordinate.latitude, long: location.coordinate.longitude)
            nextNote()
        }
    }
    
    @IBAction func favorite(sender: AnyObject) {
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        location = true
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        location = false
    }

}
