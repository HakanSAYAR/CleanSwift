//
//  DetailModels.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

enum Detail
{
    // MARK: Use cases
    
    enum SearchDetail
    {
        struct Request
        {
            
        }
        struct Response
        {
            var model: SearchResponseModel
        }
        struct ViewModel
        {
            var model: SearchDetailViewModel
        }
    }
}

struct SearchDetailViewModel {
    let imagePath: String?
    let title: String?
    let description: String?
}

