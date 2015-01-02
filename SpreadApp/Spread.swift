import UIKit

class Spread: NSObject {
    var user : String?
    var date : NSDate?
    var loc : Loc?
    var answer : String?
    
    init(json : NSDictionary){
        self.user = json["user"] as? String
        
        var date = json["date"] as? String
        self.date =  NSDate(dateString: date!.substringToIndex(advance(date!.startIndex, 10)))

        self.answer = json["answer"] as? String
        self.loc = Loc(json: json["loc"] as NSDictionary)
    }
}
