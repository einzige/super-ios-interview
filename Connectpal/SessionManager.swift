import Foundation

public class SessionManager {
    public func signIn(email: String, password: String) -> Bool {
        api.signIn(email, password: password)
        return isSignedIn()
    }
    
    public func isSignedIn() -> Bool {
        return api.isAuthorized()
    }
    
    public func signOut() {
        api.resetSession()
    }
}

let sessionManager = SessionManager()