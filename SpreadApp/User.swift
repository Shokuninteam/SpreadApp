import UIKit

class User: NSObject {
    var id : String?
    var nickname : String?
    var mail : String?
    var pwd : String?
    var avatar : NSData?
    var loc : Loc?
    var pos : [Pos]?
    var favs : [String]?
    var active : Bool?
    
    init(json : NSDictionary){
        super.init()
        self.id = json["_id"] as? String
        self.nickname = json["nickname"] as? String
        self.pwd = json["pwd"] as? String
        self.mail = json["mail"] as? String
        self.avatar = NSJSONSerialization.dataWithJSONObject(json["avatar"]!, options: .allZeros, error: nil)
        self.active = json["active"] as? Bool
        self.favs = json["favs"]  as? [String]
            
        var locJson = json["loc"] as? NSDictionary
        self.loc = Loc(json : locJson!)
        
        var posArray = json["pos"] as? [NSDictionary]
        for tempLoc in posArray! {
            if self.pos == nil {
                self.pos = [Pos(json : tempLoc as NSDictionary)]
            }
            else {
                self.pos?.append(Pos(json : tempLoc as NSDictionary))
            }
        }
    }
    
}
