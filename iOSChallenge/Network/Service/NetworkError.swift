//
//  NetworkError.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 12.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import Foundation

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

