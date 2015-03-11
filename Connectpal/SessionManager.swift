import Foundation

public class SessionManager {
    public var userData: [String: AnyObject] = [String: AnyObject]()
    
    public func signIn(email: String, password: String,
        onSuccess: (() -> ())? = nil,
        onFail: (() -> ())? = nil)
    {
        api.signIn(email, password: password) { response in
            if self.isSignedIn() {
                let responseData = response.getData()
                
                if responseData["user"] != nil {
                    self.userData = responseData["user"] as [String: AnyObject]
                }
                
                onSuccess?()
            } else {
                onFail?()
            }
        }
    }
    
    public func isSignedIn() -> Bool {
        return api.isAuthorized()
    }
    
    public func signOut() {
        api.resetSession()
    }
}

let sessionManager = SessionManager()