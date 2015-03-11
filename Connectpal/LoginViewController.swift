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
    @IBOutlet weak var logInIndicator: UIActivityIndicatorView!
    
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
        
        let alertController = UIAlertController(
            title: "Failed to Log In",
            message: "The email or password you entered doesn't appear to belong to an account. Please check your credentials and try again.",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func blockUIWithPendingLogIn() {
        logInIndicator.hidden = false
        logInIndicator.startAnimating()
        emailField.enabled = false
        passwordField.enabled = false
        logInButton.enabled = false
        logInButton.titleLabel!.text = "Please wait..."
    }
    
    private func restoreUIAfterLogIn() {
        logInIndicator.hidden = true
        logInIndicator.stopAnimating()
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