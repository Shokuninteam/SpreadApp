//
//  Loc.swift
//  SpreadApp
//
//  Created by Frank Bassard on 27/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class Loc: NSObject {
    
    var type : String?
    var coordinates : [Double]?
    
    init(json : NSDictionary){
        self.type = json["type"] as? String
        self.coordinates = json["coordinates"] as? [Double]
    }
}
