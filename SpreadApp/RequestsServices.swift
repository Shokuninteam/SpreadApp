//
//  RequestsServices.swift
//  SpreadApp
//
//  Created by Frank Bassard on 27/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class RequestsServices: NSObject {
    
    class func loginMail (mail : String, pwd :String) {
        
        let url = UrlsProvider.logIn()
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
    
    class func loginNickname (nickname : String, pwd :String) {
        
        var request = NSMutableURLRequest(URL : UrlsProvider.logIn())
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "PUT"
        
        var params = ["email":"\(nickname)", "password":"\(pwd)"] as Dictionary
        
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            println("Response: \(response)")
            
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            println("Body: \(strData)\n\n")
            
            var err: NSError?
            
            var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &err) as NSDictionary
            
            if(err != nil) {
                println(err!.localizedDescription)
            }
                
            else {
                dispatch_async(dispatch_get_main_queue(), {
                    println("setMainQueue");
                })
            }
        })
        task.resume()
    }
    
    
}
