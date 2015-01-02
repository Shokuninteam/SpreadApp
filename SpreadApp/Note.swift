import UIKit

class Note: NSObject {
    var user : String?
    var date : NSDate?
    var content : String?
    var tags : [String]?
    var spread : [Spread]?
    
    init(json : NSDictionary){
        self.user = json["user"] as? String
        
        var date = json["date"] as? String
        self.date =  NSDate(dateString: date!.substringToIndex(advance(date!.startIndex, 10)))

        
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
