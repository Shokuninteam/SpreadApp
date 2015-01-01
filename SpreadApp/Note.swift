//
//  Note.swift
//  SpreadApp
//
//  Created by Frank Bassard on 27/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class Note: NSObject {
    var user : String?
    var date : NSDate?
    var content : String?
    var tags : [String]?
    var spread : [Spread]?
    
    init(json : NSDictionary){
        
    }
}
