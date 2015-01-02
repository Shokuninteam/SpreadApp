import UIKit

class Note: NSObject {
    var user : String?
    var date : NSDate?
    var content : String?
    var tags : [String]?
    var spread : [Spread]?
    
    init(json : NSDictionary){
        self.user = json["user"] as? String
        self.date = json["date"] as? NSDate
        self.content = json["content"] as? String
        self.tags = json["tags"] as? [String]
        
        var spreadArray = json["spread"] as? [NSDictionary]
        for tempSpread in spreadArray! {
            if self.spread == nil {
                self.spread = [Spread(json : tempSpread as NSDictionary)]
            }
            else {
                self.spread?.append(Spread(json : tempSpread as NSDictionary))
            }
        }
    }
}
