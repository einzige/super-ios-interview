import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
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
    
    override func viewDidLoad() {
        emailField.delegate = self
        passwordField.delegate = self
        emailField.canBecomeFirstResponder()
        passwordField.canBecomeFirstResponder()
        api.resetSession()
        emailField.text = "szinin@gmail.com"
        passwordField.text = "gfhjkmqe"
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == passwordField) {
            passwordField.resignFirstResponder()
            login()
        } else if (textField == emailField) {
            passwordField.becomeFirstResponder()
        }
        
        return true
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return identifier != "login_success"
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
        passwordField.text = ""
        logInButton.enabled = true
        logInButton.titleLabel!.text = "Log In"
    }
}