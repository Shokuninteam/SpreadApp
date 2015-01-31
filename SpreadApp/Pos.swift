import UIKit

class Pos: NSObject {
    
    var date : NSDate?
    var loc : Loc?
    
    init(json : NSDictionary){
        var date = json["date"] as? String
        self.date =  NSDate(dateString: date!.substringToIndex(advance(date!.startIndex, 10)))

        self.loc = Loc(json: json["loc"] as NSDictionary!)
    }
}
