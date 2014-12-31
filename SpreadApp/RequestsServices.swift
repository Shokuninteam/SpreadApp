import UIKit

class RequestsServices: NSObject {
    
    //var err: NSError?
    //var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &err) as NSDictionary
    //if(err != nil) {
    //    println(err!.localizedDescription)
    //}
    
    var loginControllerDelegate : LoginController?
    var registerControllerDelegate : RegisterController?
    
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
        
        var params = ["nickname":"\(nickname)", "pwd":"\(pwd)", "mail":"\(mail)", "long":"\(long)", "lat":"\(lat)", "avatar":"\(avatar)"] as Dictionary
        
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
    
    
}
