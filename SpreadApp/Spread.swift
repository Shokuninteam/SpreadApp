//
//  Spread.swift
//  SpreadApp
//
//  Created by Frank Bassard on 27/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class Spread: NSObject {
    var user : String?
    var date : NSDate?
    var loc : Loc?
    var answer : String?
    
    init(json : NSDictionary){
        self.user = json["user"] as? String
        self.date = json["date"] as? NSDate
        self.answer = json["answer"] as? String
        self.loc = Loc(json: json["loc"] as NSDictionary)
    }
}
