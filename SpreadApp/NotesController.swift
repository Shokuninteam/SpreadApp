import UIKit

class NotesController: UIPageTargetViewController, NotesRequestDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var requestsServices = RequestsServices()
    var topNotes : [Note]?
    var favNotes : [Note]?
    var spreadedNotes : [Note]?
    
    var current = "top"
    
    @IBOutlet var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestsServices.notesControllerDelegate = self
        super.index = 2
        var id : NSString? = NSUserDefaults.standardUserDefaults().objectForKey("userId") as? NSString
        if id != nil {
            requestsServices.getSpreaded(id!)
            requestsServices.getfavs(id!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func notesTopRequestHandler(topNotes : [Note]){
        self.topNotes = topNotes
        println("top loaded")
    }
    
    func notesFavsRequestHandler(favNotes : [Note]){
        self.favNotes = favNotes
        println("fav loaded")
    }
    
    func notesSpreadedRequestHandler(spreadedNotes : [Note]){
        self.spreadedNotes = spreadedNotes
        println("spreaded loaded")
    }
    
    @IBAction func clickSpreaded(sender: AnyObject) {
        self.current = "spreaded"
        self.notesTableView.reloadData()
    }
    
    @IBAction func clickFavs(sender: AnyObject) {
        self.current = "favs"
        self.notesTableView.reloadData()
    }
    
    @IBAction func clickTop(sender: AnyObject) {
        self.current = "top"
        self.notesTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.current == "top" {
            if topNotes == nil {
                println("0 top notes")
                return 0
            } else {
                return countElements(topNotes!)
            }
        } else if self.current == "favs"{
            if favNotes == nil {
                println("0 fav notes")
                return 0
            } else {
                return countElements(favNotes!)
            }
        } else {
            if spreadedNotes == nil {
                println("0 spreaded notes")                
                return 0
            } else {
                return countElements(spreadedNotes!)
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell : NoteCell = tableView.dequeueReusableCellWithIdentifier("noteCell") as NoteCell
        var note : Note?
        
        if self.current == "top" {
            note = self.topNotes![indexPath.item]
        } else if self.current == "favs"{
            note = self.favNotes![indexPath.item]
        } else {
            note = self.spreadedNotes![indexPath.item]
        }
        
        cell.content.text = note!.content
        cell.count.text = "\(countElements(note!.spread!))"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        cell.date.text = dateFormatter.stringFromDate(note!.date!)
        
        var tags = ""
        for tag in note!.tags! {
            tags += " #\(tag)"
        }
        cell.tags.text = tags

        return cell

    }

}