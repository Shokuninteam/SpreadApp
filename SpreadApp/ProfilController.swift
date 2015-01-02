import UIKit

class ProfilController: UIPageTargetViewController, ProfilRequestDelegate, UITableViewDataSource, UITableViewDelegate{
    

    @IBOutlet var avatar: UIImageView!
    @IBOutlet var nickName: UILabel!
    @IBOutlet var profileTableView: UITableView!
    var notes : [Note]?
    
    let requestsServices = RequestsServices()
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.index = 0
        requestsServices.profileControllerDelegate = self
        var id : NSString? = NSUserDefaults.standardUserDefaults().objectForKey("userId") as? NSString
        if id != nil {
            requestsServices.getUserProfil(id!)
            requestsServices.getUserHistory(id!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func profilUserRequestHandler(user : User){
        self.user = user
        nickName.text = user.nickname
        var img = UIImage(data: user.avatar!)
        avatar.image = img
    }
    
    func profilHistoryRequestHandler(notes: [Note]){
        self.notes = notes
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if notes == nil {
            return 0
        } else {
            return countElements(self.notes!)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell : NoteCell = tableView.dequeueReusableCellWithIdentifier("profilCell") as NoteCell
        var note = self.notes![indexPath.item]
        cell.content.text = note.content
        cell.count.text = "\(countElements(note.spread!))"
        var tags = ""
        for tag in note.tags! {
            tags += " #\(tag)"
        }
        cell.tags.text = tags
        
        return cell
    }
    
    
}
