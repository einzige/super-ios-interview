//
//  request.swift
//  Connectpal
//
//  Created by Sergei Zinin on 10/03/15.
//  Copyright (c) 2015 Connectpal. All rights reserved.
//

import Foundation

class Request {
    let host = "http://localhost:3000"
    let namespace = "/api"
    let base_url: String
   
    class var x: String { return "fuckoff" }
    
    init() {
        self.base_url = host + namespace
    }
}