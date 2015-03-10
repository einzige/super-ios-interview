//
//  LoginViewController.swift
//  Connectpal
//
//  Created by Sergei Zinin on 10/03/15.
//  Copyright (c) 2015 Connectpal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func login() {
        if emailField.text == "szinin@gmail.com" {
          performSegueWithIdentifier("login_success", sender: self)
        }
    }
    
    override func viewDidLoad() {
        api.resetSession()
        super.viewDidLoad()
    }
}