//
//  MainInteractor.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

protocol MainBusinessLogic
{
    func doSearchResults(request: Main.Search.Request)
    func doDeleteItem()
    func doSelectItem(index: Int)
}

protocol MainDataStore
{
    var model : [SearchResponseModel] { get set }
    var deletedIds: [Int] { get set }
    var deleteId: Int? { get set }
    var visitedIds: [Int] { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore
{
    var deleteId: Int?{
        didSet{
            if deleteId != nil {
                doDeleteItem()
            }
        }
    }
    
    var deletedIds: [Int] = []
    var visitedIds: [Int] = []
    var model: [SearchResponseModel] = []
    var presenter: MainPresentationLogic?
    var worker: MainWorker?
    var media: SearchType = .all
    
    // MARK: Do something
    
    func doSearchResults(request: Main.Search.Request) {
        worker = MainWorker()
        deletedIds = worker?.doGetDeletedItems() ?? []
        visitedIds = worker?.doGetVisitedItems() ?? []
        worker?.doSearch(request: request.model, completion: { (model, error) in
            guard let item = model else{return}
            self.model = item.filter{[weak self] in
                guard let sSelf = self else {return false}
                return !sSelf.deletedIds.contains($0.trackId)
            }
            let response = Main.Search.Response(model: self.model, media: self.media, selectedIds: self.visitedIds)
            self.presenter?.presentSearch(response: response)
        })
    }
    
    func doDeleteItem() {
        guard let index = model.firstIndex(where: { (model) -> Bool in
            model.trackId == deleteId
        })else {return}
        presenter?.presentDelete(index: index)
        if let id = deleteId, !deletedIds.contains(id){
            deletedIds.append(id)
            worker?.saveDeletedItems(ids: deletedIds)
        }
        
    }
    
    func doSelectItem(index: Int){
        let id = self.model[index].trackId
        if !visitedIds.contains(id){
            visitedIds.append(id)
            worker?.saveVisitedItems(ids: visitedIds)
            let response = Main.Search.Response(model: self.model, media: self.media, selectedIds: self.visitedIds)
            self.presenter?.presentSearch(response: response)
        }
        
    }
}





