//
//  NewsFeedController.swift
//  SpreadApp
//
//  Created by Mohamed Mokhtari on 26/12/2014.
//  Copyright (c) 2014 Shokunin. All rights reserved.
//

import UIKit

class NewsFeedController: UIPageTargetViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.index = 1
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
