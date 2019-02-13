//
//  DetailPresenter.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//


import UIKit

protocol DetailPresentationLogic
{
    func presentSomething(response: Detail.SearchDetail.Response)
}

class DetailPresenter: DetailPresentationLogic
{
    weak var viewController: DetailDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Detail.SearchDetail.Response)
    {
        let model = SearchDetailViewModel.init(imagePath: response.model.artworkUrl100,
                                               title: response.model.artistName,
                                               description: response.model.longDescription)
        let viewModel = Detail.SearchDetail.ViewModel(model: model)
        viewController?.displaySearchDetail(viewModel: viewModel)
    }
}

