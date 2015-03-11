import Foundation

public class API {
    public var token: String?
    private var request: APIRequest
    
    public init(token: String? = nil) {
        self.token = token
        self.request = APIRequest(token: token)
    }
    
    public func signIn(email: String, password: String) -> APIResponse {
        let response = post("/sessions", params: ["email": email, "password": password])
        let token = response.getToken()
        
        // Authorize app once token is received
        if token != nil { authorize(token) }
        
        return response
    }
    
    public func resetSession() {
        self.token = nil
    }
    
    public func isAuthorized() -> Bool {
        return token != nil
    }
    
    private func get(path: String, params: [String: String]) -> APIResponse {
        return request.get(path, params: params)
    }
    
    private func post(path: String, params: [String: String]) -> APIResponse {
        return request.post(path, params: params)
    }
    
    private func authorize(token: String?) {
        self.token = token
        self.request = APIRequest(token: token)
    }
}

public var api = API()