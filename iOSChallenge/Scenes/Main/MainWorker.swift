//
//  MainWorker.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

enum StoreKeys{
    static let deletedKey = "deletedItems"
    static let visitedKey = "visitedItems"
}

class MainWorker
{
    func doSearch(request: SearchRequestModel, completion: @escaping NetworkRouterDecodableCompletion<[SearchResponseModel]>)
    {
        NetworkManager.shared.getSearch(request: request, completion: completion)
    }
    
    func doGetDeletedItems() -> [Int]{
        return (UserDefaults.standard.array(forKey: StoreKeys.deletedKey) as? [Int]) ?? []
    }
    
    func saveDeletedItems(ids: [Int]){
        UserDefaults.standard.set(ids, forKey: StoreKeys.deletedKey)
    }
    
    func doGetVisitedItems() -> [Int]{
        return (UserDefaults.standard.array(forKey: StoreKeys.visitedKey) as? [Int]) ?? []
    }
    
    func saveVisitedItems(ids: [Int]){
        UserDefaults.standard.set(ids, forKey: StoreKeys.visitedKey)
    }
    
}

