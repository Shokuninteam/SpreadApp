import UIKit

class ProfilController: UIPageTargetViewController, ProfilRequestDelegate{
    

    @IBOutlet var avatar: UIImageView!
    @IBOutlet var nickName: UILabel!
    
    let requestsServices = RequestsServices()
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.index = 0
        requestsServices.profileControllerDelegate = self
        var id : NSString? = NSUserDefaults.standardUserDefaults().objectForKey("userId") as? NSString
        if id != nil {
            requestsServices.getUserProfil(id!)
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
        
        println(UIImagePNGRepresentation(img))
        println(UIImagePNGRepresentation(UIImage(named: "avatar-male")))
    }
    
    func profilHistoryRequestHandler(notes: [Note]){
        
    }
    
    
}
