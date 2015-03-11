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
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func login() {
        blockUIWithPendingLogIn()
        
        sessionManager.signIn(emailField.text, password: passwordField.text,
            onSuccess: onLoginSuccess,
            onFail: onLoginFailed)
    }
    
    private func onLoginSuccess() {
        restoreUIAfterLogIn()
        performSegueWithIdentifier("login_success", sender: self)
    }
    
    private func onLoginFailed() {
        restoreUIAfterLogIn()
    }
    
    private func blockUIWithPendingLogIn() {
        emailField.enabled = false
        passwordField.enabled = false
        logInButton.enabled = false
        logInButton.titleLabel!.text = "Please wait..."
    }
    
    private func restoreUIAfterLogIn() {
        emailField.enabled = true
        passwordField.enabled = true
        logInButton.enabled = true
        logInButton.titleLabel!.text = "Log In"
    }
    
    override func viewDidLoad() {
        api.resetSession()
        super.viewDidLoad()
    }
}