//
//  PopupPresenter.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 10.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

protocol PopupPresentationLogic
{
    func presentTellMain(response: Popup.TellMain.Response)
}

class PopupPresenter: PopupPresentationLogic
{
    weak var viewController: PopupDisplayLogic?
    
    // MARK: Do something
    
    func presentTellMain(response: Popup.TellMain.Response)
    {
        let viewModel = Popup.TellMain.ViewModel()
        viewController?.displayTellMain(viewModel: viewModel)
    }
}

