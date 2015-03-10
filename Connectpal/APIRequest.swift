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
    public let baseUrl: String
    
    public init() {
        self.baseUrl = host + namespace
    }
}