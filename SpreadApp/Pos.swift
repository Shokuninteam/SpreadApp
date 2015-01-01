//
//  Pos.swift
//  SpreadApp
//
//  Created by Frank Bassard on 27/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class Pos: NSObject {
    
    var date : NSDate?
    var loc : Loc?
    
    init(json : NSDictionary){
        self.date = json["date"] as? NSDate
        self.loc = Loc(json: json["loc"] as NSDictionary!)
    }
}
