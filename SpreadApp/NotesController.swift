import UIKit

class NotesController: UIPageTargetViewController, NotesRequestDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var requestsServices = RequestsServices()
    var topNotes : [Note]?
    var favNotes : [Note]?
    var spreadedNotes : [Note]?
    var targetedNote : Note?
    
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
    }
    
    func notesFavsRequestHandler(favNotes : [Note]){
        self.favNotes = favNotes
    }
    
    func notesSpreadedRequestHandler(spreadedNotes : [Note]){
        self.spreadedNotes = spreadedNotes
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
                return 0
            } else {
                return countElements(topNotes!)
            }
        } else if self.current == "favs"{
            if favNotes == nil {
                return 0
            } else {
                return countElements(favNotes!)
            }
        } else {
            if spreadedNotes == nil {
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if current == "top" {
            self.targetedNote = topNotes![indexPath.row]
        } else if current == "favs" {
            self.targetedNote = favNotes![indexPath.row]
        } else {
            self.targetedNote = spreadedNotes![indexPath.row]
        }
        performSegueWithIdentifier("MapFromNotesSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MapFromNotesSegue"{
            var target = segue.destinationViewController as MapController
            target.note = self.targetedNote
        }
    }

}