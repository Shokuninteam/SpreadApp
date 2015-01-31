import UIKit

class Loc: NSObject {
    
    var type : String?
    var coordinates : [Double]?
    
    init(json : NSDictionary){
        self.type = json["type"] as? String
        self.coordinates = json["coordinates"] as? [Double]
    }
}
