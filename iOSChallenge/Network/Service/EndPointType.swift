//
//  EndPointType.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get}
}

