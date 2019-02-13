//
//  NetworkManager.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 10.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    static let environment : NetworkEnvironment = .production
    let router = Router<SearchRouter>()
    
    func getSearch(request: SearchRequestModel, completion: @escaping NetworkRouterDecodableCompletion<[SearchResponseModel]>){
        router.requestDecodable(SearchResult.self, SearchRouter.search(model: request)) { (model, error) in
            completion(model?.results, error)
        }
    }
}

