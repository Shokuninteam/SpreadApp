import UIKit

class RequestsServices: NSObject {
    
    var loginControllerDelegate : LoginController?
    var registerControllerDelegate : RegisterController?
    var createNoteControllerDelegate : CreateNoteController?
    var profileControllerDelegate : ProfilController?
    
    func loginNickname (nickname : String, pwd :String) {
        
        var request = NSMutableURLRequest(URL : UrlsProvider.logIn())
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "PUT"
        
        var params = ["nickname":"\(nickname)", "pwd":"\(pwd)"] as Dictionary
        
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var code = 404
            var id = ""
            
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
                if let userId = httpResponse.allHeaderFields["id"] as? NSString {
                    id = userId
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.loginControllerDelegate!.loginRequestHandler(code, id : id)
            })
        })
        task.resume()
    }
    
    func loginMail (mail : String, pwd :String) {
        
        var request = NSMutableURLRequest(URL : UrlsProvider.logIn())
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "PUT"
        
        var params = ["mail":"\(mail)", "pwd":"\(pwd)"] as Dictionary
        
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var code = 404
            var id = ""
            
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
                if let userId = httpResponse.allHeaderFields["id"] as? NSString {
                    id = userId
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.loginControllerDelegate!.loginRequestHandler(code, id : id)
            })
        })
        task.resume()
    }
    
    func register (nickname : String, mail : String, pwd :String, gender : String, long : Double, lat : Double) {
        
        var request = NSMutableURLRequest(URL : UrlsProvider.createUser())
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        var img : UIImage?
        
        if gender == "male" {
            img = UIImage(named: "avatar-male")
        } else {
            img = UIImage(named: "avatar-female")
        }
        var avatar : NSData = UIImagePNGRepresentation(img)
        var avatarString = avatar.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        var params = ["nickname":"\(nickname)", "pwd":"\(pwd)", "mail":"\(mail)", "long":"\(long)", "lat":"\(lat)", "avatar":"\(avatarString)"] as Dictionary
        
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var code = 404
            var id = ""
            
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
                if let userId = httpResponse.allHeaderFields["id"] as? NSString {
                    id = userId
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.registerControllerDelegate!.registerRequestHandler(code, id : id)
            })
        })
        task.resume()
    }
    
    func createNote (content : String, tags : String, user :String, long : Double, lat : Double) {
        
        var request = NSMutableURLRequest(URL : UrlsProvider.createNote())
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        var params = ["content":"\(content)", "tags":"\(tags)", "user":"\(user)", "long":"\(long)", "lat":"\(lat)"] as Dictionary
        
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var code = 404
            var id = ""
            
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.createNoteControllerDelegate!.createNoteRequestHandler(code)
            })
        })
        task.resume()
    }

    func getUserProfil (id : String) {
        
        var request = NSMutableURLRequest(URL : UrlsProvider.getUserById(id))
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var code = 404
            var json : NSDictionary?
            
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            if code == 200 || code == 304{
                var err: NSError?
                json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &err) as? NSDictionary
                if(err != nil) {
                    println(err!.localizedDescription)
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                var user = User(json : json!)
                self.profileControllerDelegate?.profilUserRequestHandler(user)
            })
        })
        task.resume()
    }
    
    func getUserHistory (id : String) {
        
        var request = NSMutableURLRequest(URL : UrlsProvider.getHistory(id))
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var code = 404
            var json : NSArray?
            
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            if code == 200 || code == 304{
                var err: NSError?
                json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &err) as? NSArray
                if(err != nil) {
                    println(err!.localizedDescription)
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                var notesArray = [Note]()
                for noteJson in json! {
                    notesArray.append(Note(json: noteJson as NSDictionary))
                }
                self.profileControllerDelegate?.profilHistoryRequestHandler(notesArray)
            })
        })
        task.resume()
    }
    
}
