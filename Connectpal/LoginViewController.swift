//
//  LoginViewController.swift
//  Connectpal
//
//  Created by Sergei Zinin on 10/03/15.
//  Copyright (c) 2015 Connectpal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBAction func login() {
        performSegueWithIdentifier("login_success", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}