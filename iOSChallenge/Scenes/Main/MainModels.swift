//
//  MainModels.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

enum Main
{
    // MARK: Use cases
    
    enum Search
    {
        struct Request
        {
            let model: SearchRequestModel
        }
        struct Response
        {
            var model: [SearchResponseModel]
            var media: SearchType
            var selectedIds: [Int]
        }
        struct ViewModel
        {
            var model: [SearchListViewModel]
        }
    }
}

struct SearchListViewModel {
    let imagePath: String?
    let title: String?
    var isVisited: Bool
}

