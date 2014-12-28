//
//  UrlsProvider.swift
//  SpreadApp
//
//  Created by Frank Bassard on 27/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class UrlsProvider: NSObject {
    class func getBaseUrl () -> String {
        return "http://localhost:8080/"
    }
    
    class func getUserById (id : String) -> NSURL {
        return NSURL(string: getBaseUrl() + "users/" + id)!
    }
    
    class func logIn () -> NSURL {
        return NSURL(string: getBaseUrl() + "users")!
    }
    
    class func createUser () -> NSURL {
        return NSURL(string : getBaseUrl() + "users")!
    }
    
    class func modifyUser (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id)!
    }
    
    class func deleteUser (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id)!
    }
    
    class func addPosition (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id + "/positions")!
    }
    
    class func getFavs (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id + "/notes/favoris")!
    }
    
    class func addFav (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id + "/notes/favoris")!
    }
    
    class func getHistory (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id + "/notes/history")!
    }
    
    class func spreadNote (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id + "/notes/spreaded")!
    }
    
    class func discardNote (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id + "/notes/discard")!
    }
    
    class func getSpreaded (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id + "/notes/spreaded")!
    }
    
    class func getUnanswered (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "users/" + id + "/notes/unanswered")!
    }
    
    class func getNote (id : String) -> NSURL {
        return NSURL(string : getBaseUrl() + "notes/" + id)!
    }
    
    class func createNote () -> NSURL {
        return NSURL(string : getBaseUrl() + "notes")!
    }
}
