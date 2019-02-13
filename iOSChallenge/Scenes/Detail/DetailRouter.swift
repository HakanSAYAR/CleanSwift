//
//  DetailRouter.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

@objc protocol DetailRoutingLogic
{
    func routeToMain(segue: UIStoryboardSegue?)
}

protocol DetailDataPassing
{
    var dataStore: DetailDataStore? { get }
}

class DetailRouter: NSObject, DetailRoutingLogic, DetailDataPassing
{
    weak var viewController: DetailViewController?
    var dataStore: DetailDataStore?
    
    // MARK: Routing
    
    func routeToMain(segue: UIStoryboardSegue?)
    {
        let destinationVC = viewController!.navigationController!.viewControllers.first as! MainViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMain(source: self.dataStore!, destination: &destinationDS)
        navigateToMain(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToMain(source: DetailViewController, destination: MainViewController)
    {
        source.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToMain(source: DetailDataStore, destination: inout MainDataStore)
    {
        destination.deleteId = source.model?.trackId
        //        destination.indexPath = source.indexPath
    }
}


