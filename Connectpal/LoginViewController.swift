//
//  LoginViewController.swift
//  Connectpal
//
//  Created by Sergei Zinin on 10/03/15.
//  Copyright (c) 2015 Connectpal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func login() {
        let signedIn = sessionManager.signIn(emailField.text, password: passwordField.text)
        
        if signedIn {
            performSegueWithIdentifier("login_success", sender: self)
        } else {
            
        }
    }
    
    override func viewDidLoad() {
        api.resetSession()
        super.viewDidLoad()
    }
}