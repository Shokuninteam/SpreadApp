import UIKit

class NewsFeedController: UIPageTargetViewController, FeedRequestDelegate{
    
    let requestsServices = RequestsServices()
    var unansweredNotes : [Note]?
    var currentNote : Note?
    var author : User?
    
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
        self.currentNote = self.unansweredNotes!.removeLast() as Note
        requestsServices.getNoteUser(self.currentNote!.user!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date.text = dateFormatter.stringFromDate(self.currentNote!.date!)
        self.content.text = self.currentNote!.content
        self.spreadCount.text = "\(countElements(self.currentNote!.spread!))"
    }
    
    func feedNoteUserRquestHandler(user : User){
        self.author = user
        self.authorName.text = user.nickname
        //var img = UIImage(data: user.avatar!)
        //avatar.image = img
    }
    
    @IBAction func Share(sender: AnyObject) {
    }
    
    @IBAction func report(sender: AnyObject) {
    }
    
    @IBAction func favorite(sender: AnyObject) {
    }
    

}
