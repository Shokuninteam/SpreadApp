//
//  LoginController.swift
//  SpreadApp
//
//  Created by Mohamed Mokhtari on 26/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBAction func SignIn(sender: UIButton) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

