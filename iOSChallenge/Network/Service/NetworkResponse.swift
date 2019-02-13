//
//  NetworkResponse.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 12.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

