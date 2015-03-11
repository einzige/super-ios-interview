import Foundation

public class APIRequest {
    let host = "http://localhost:3000"
    let namespace = "/api"
    
    var token: String?
    
    public init(token: String? = nil) {
        self.token = token
    }
    
    public func get(path: String, params: [String: AnyObject]? = nil) -> APIResponse {
        return getJSON(buildURL(path))
    }
    
    public func post(path: String, params: [String: AnyObject]) -> APIResponse {
        return postJSON(buildURL(path), data: params)
    }
    
    private func buildURL(path: String) -> String {
        return (host + namespace + "/" + path).stringByReplacingOccurrencesOfString("//", withString: "/")
    }
    
    private func getJSON(url: String) -> APIResponse {
        return sendRequest(buildHTTPRequest(url))
    }
    
    private func postJSON(url: String, data: AnyObject) -> APIResponse {
        let request = buildHTTPRequest(url, type: "POST")
        request.HTTPBody = toJSON(data).dataUsingEncoding(NSUTF8StringEncoding)
    
        return sendRequest(request)
    }
    
    private func buildHTTPRequest(url: String, type: String = "GET") -> NSMutableURLRequest {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if token != nil {
            request.setValue("Token token=\"\(token)\"", forHTTPHeaderField: "HTTP_AUTHORIZATION")
        }
        
        request.HTTPMethod = type
        
        return request
    }
    
    private func sendRequest(request: NSMutableURLRequest) -> APIResponse {
        var response: NSURLResponse?
        var e: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &e)
        
        if e != nil {
            return APIResponse(data: ["error": e!.localizedDescription])
        }
        
        if data != nil {
            return APIResponse(data: responseDataToDictionary(data!))
        }
        
        return APIResponse(data: [String: AnyObject]())
    }
    
    private func responseDataToDictionary(data: NSData) -> [String: AnyObject] {
        var e: NSError?
        var jsonObj = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &e) as [String: AnyObject]
        
        if e != nil {
            return [String: AnyObject]()
        } else {
            return jsonObj
        }
    }
    
    private func toJSON(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string
                }
            }
        }
        return ""
    }
}