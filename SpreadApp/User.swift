//
//  User.swift
//  SpreadApp
//
//  Created by Frank Bassard on 27/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class User: NSObject {
    var nickname : String?
    var mail : String?
    var pwd : String?
    var avatar : String?
    var loc : Loc?
    var pos : [Pos]?
    var favs : [String]?
    var active : Bool?
}
