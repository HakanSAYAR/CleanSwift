//
//  MainPresenter.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

protocol MainPresentationLogic
{
    func presentSearch(response: Main.Search.Response)
    func presentDelete(index: Int)
}

class MainPresenter: MainPresentationLogic
{
    weak var viewController: MainDisplayLogic?
    
    // MARK: Do something
    
    func presentSearch(response: Main.Search.Response)
    {
        let viewModels = response.model.map {item -> SearchListViewModel in
            let isVisited = response.selectedIds.contains(item.trackId)
            return SearchListViewModel(imagePath: item.artworkUrl100, title: item.artistName, isVisited: isVisited)
        }
        viewController?.displaySearchResults(viewModel: Main.Search.ViewModel.init(model: viewModels))
    }
    
    func presentDelete(index: Int){
        viewController?.displayDelete(index: index )
    }
    
}


