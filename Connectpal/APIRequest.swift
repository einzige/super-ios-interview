//
//  request.swift
//  Connectpal
//
//  Created by Sergei Zinin on 10/03/15.
//  Copyright (c) 2015 Connectpal. All rights reserved.
//

import Foundation

public class APIRequest {
    let host = "http://localhost:3000"
    let namespace = "/api"
    
    var token: String?
    
    public init(token: String? = nil) {
        self.token = token
    }
    
    public func get(path: String, callback: (() -> ())?) {
        getJSON(buildURL(path)) { data, error in
        }
    }
    
    private func buildURL(path: String) -> String {
        return (host + namespace + "/" + path).stringByReplacingOccurrencesOfString("//", withString: "/")
    }
    
    private func getJSON(url: String, callback: (Dictionary<String, AnyObject>, String?) -> Void) {
        sendRequest(buildHTTPRequest(url), callback)
    }
    
    private func postJSON(url: String, data: AnyObject, callback: (Dictionary<String, AnyObject>, String?) -> Void) {
        let request = buildHTTPRequest(url, type: "POST")
        request.HTTPBody = toJSON(data).dataUsingEncoding(NSUTF8StringEncoding)
        
        sendRequest(request, callback)
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
    
    private func sendRequest(request: NSMutableURLRequest, callback: (Dictionary<String, AnyObject>, String?) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, {
            data, response, e in
            
            if e != nil {
                callback(Dictionary<String, AnyObject>(), e.localizedDescription)
            } else {
                callback(self.responseDataToDictionary(data), nil)
            }
        })
        
        task.resume()
    }
    
    private func responseDataToDictionary(data: NSData) -> Dictionary<String, AnyObject> {
        var e: NSError?
        var jsonObj = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &e) as Dictionary<String, AnyObject>
        
        if e != nil {
            return Dictionary<String, AnyObject>()
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