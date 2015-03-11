//
//  APIResponse.swift
//  Connectpal
//
//  Created by Sergei Zinin on 10/03/15.
//  Copyright (c) 2015 Connectpal. All rights reserved.
//

import Foundation

public class APIResponse {
    public var data: [String: AnyObject]
    
    public init(data: [String: AnyObject]) {
        self.data = data
    }
    
    public func getData() -> [String: AnyObject]? {
        if data["data"] != nil {
            return data["data"] as? [String: AnyObject]
        } else {
            return nil
        }
    }
    
    public func getToken() -> String? {
        if data["api_token"] != nil {
            return data["api_token"] as? String
        } else {
            return nil
        }
    }
    
    public func isSuccess() -> Bool {
        return data["status"] as? String == "success"
    }
}