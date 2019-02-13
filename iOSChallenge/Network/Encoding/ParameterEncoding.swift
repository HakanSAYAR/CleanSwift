//
//  ParameterEncoding.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import Foundation

public typealias Parameters = [String : Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    
    public func encode(urlRequest: inout URLRequest,
                       parameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = parameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = parameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        }catch {
            throw error
        }
    }
}

