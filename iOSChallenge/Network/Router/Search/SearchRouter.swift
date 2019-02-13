//
//  SearchEndPoint.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

enum SearchType : String {
    case movie
    case podcast
    case music
    case all
}

enum SearchRouter {
    case search(model: SearchRequestModel)
}

struct SearchRequestModel{
    let media: SearchType
    let entity: SearchType
    let limit: Int
    let term: String
}

struct SearchResult: Codable{
    let results: [SearchResponseModel]
}

struct SearchResponseModel: Codable {
    let trackId: Int
    let artistName: String?
    let artworkUrl100: String?
    let longDescription: String?
}

extension SearchRouter: EndPointType {
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let model):
            var entity = ""
            switch model.media {
            case .music:
                entity  = "album"
            case .all:
                entity = "audiobook"
            default:
                entity = model.media.rawValue
            }
            return ["term": model.term,
                    "media": model.media.rawValue,
                    "limit": model.limit,
                    "entity": entity]
        }
    }
    
    var parameterEncoding: ParameterEncoding{
        switch self {
        case .search:
            return .urlEncoding
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .search:
            return .requestParameters(parameters: parameters,
                                      encoding: .urlEncoding)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .search:
            return nil
        }
    }
}

