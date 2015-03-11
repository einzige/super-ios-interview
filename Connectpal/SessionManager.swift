import Foundation

public class SessionManager {
    public func signIn(email: String, password: String,
        onSuccess: (() -> ())?,
        onFail: (() -> ())?)
    {
        api.signIn(email, password: password) { (response: APIResponse) in
            if self.isSignedIn() {
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