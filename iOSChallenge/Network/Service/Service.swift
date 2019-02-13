//
//  Service.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 12.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import Foundation

class Service: NSObject {
    static var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    static var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://itunes.apple.com"
        case .qa: return ""
        case .staging: return ""
        }
    }
    
}

