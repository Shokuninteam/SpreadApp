//
//  UrlsProvider.swift
//  SpreadApp
//
//  Created by Frank Bassard on 27/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class UrlsProvider: NSObject {
    let baseUrl = "http://localhost:8080/"
    
    func getUserById (id : String) -> String {
        return baseUrl + "users/" + id
    }
    
    func createUser () -> String {
        return baseUrl + "users"
    }
    
    func modifyUser (id : String) -> String {
        return baseUrl + "users/" + id
    }
    
    func deleteUser (id : String) -> String {
        return baseUrl + "users/" + id
    }
    
    func addPosition (id : String) -> String {
        return baseUrl + "users/" + id + "/positions"
    }
}
