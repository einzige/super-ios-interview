import Foundation

public class API {
    public var token: String?
    private var request: APIRequest
    
    public init(token: String? = nil) {
        self.token = token
        self.request = APIRequest(token: token)
    }
    
    public func signIn(email: String, password: String, callback: ((APIResponse) -> ())?) {
        {
            return self.post("/sessions", params: ["email": email, "password": password])
        } ~> { (response: APIResponse) in
            let token = response.getToken()
            
            // Authorize app once token is received
            if token != nil { self.authorize(token) }
            if callback != nil { callback!(response) }
        }
    }
    
    public func feed() -> APIResponse {
        return self.get("/posts/feed")
    }
    
    public func resetSession() {
        self.token = nil
    }
    
    public func isAuthorized() -> Bool {
        return token != nil
    }
    
    private func get(path: String, params: [String: String]? = nil) -> APIResponse {
        return request.get(path, params: params)
    }
    
    private func post(path: String, params: [String: String]? = nil) -> APIResponse {
        return request.post(path, params: params)
    }
    
    private func authorize(token: String?) {
        self.token = token
        self.request = APIRequest(token: token)
    }
}

public var api = API()