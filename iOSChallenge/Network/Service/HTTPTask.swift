//
//  HTTPTask.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String : String]

public enum HTTPTask {
    case request
    
    case requestParameters(parameters: Parameters?,
        encoding: ParameterEncoding)
    
    case requestParametersAndHeaders(parameters: Parameters?,
        encoding: ParameterEncoding,
        additionHeaders: HTTPHeaders?)
}

