//
//  DetailInteractor.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//
import UIKit

protocol DetailBusinessLogic
{
    func doSomething(request: Detail.SearchDetail.Request)
}

protocol DetailDataStore
{
    var model: SearchResponseModel? { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore
{
    var model: SearchResponseModel?
    
    var presenter: DetailPresentationLogic?
    var worker: DetailWorker?
    
    // MARK: Do something
    
    func doSomething(request: Detail.SearchDetail.Request)
    {
        worker = DetailWorker()
        worker?.doSomeWork()
        
        let response = Detail.SearchDetail.Response(model: model!)
        presenter?.presentSomething(response: response)
    }
}


