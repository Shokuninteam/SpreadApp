import UIKit

class LoginController: UIViewController, LoginRequestDelegate {
    
    var userId : String?
    var requestServices = RequestsServices()
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var pwd: UITextField!
    
    @IBAction func SignIn(sender: UIButton) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        requestServices.loginControllerDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signIn(sender: UIButton) {
        requestServices.loginNickname(userName.text, pwd: pwd.text)
    }
    
    func loginRequestHandler(code : Int, id : String) {
        println(code)
        println(id)
    }
    
}

