//
//  PopupInteractor.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 10.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

protocol PopupBusinessLogic
{
    func doTellMain(request: Popup.TellMain.Request)
}

protocol PopupDataStore
{
    
}

class PopupInteractor: PopupBusinessLogic, PopupDataStore
{
    
    var presenter: PopupPresentationLogic?
    var worker: PopupWorker?
    
    // MARK: Do something
    
    func doTellMain(request: Popup.TellMain.Request)
    {
        //    worker = PopupWorker()
        //    worker?.doSomeWork()
        let response = Popup.TellMain.Response()
        presenter?.presentTellMain(response: response)
    }
}

