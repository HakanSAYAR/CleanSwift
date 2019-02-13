//
//  MainRouter.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

@objc protocol MainRoutingLogic
{
    func routeToPopup(segue: UIStoryboardSegue?)
    func routeToDetail(segue: UIStoryboardSegue?, indexPath: IndexPath)
}

protocol MainDataPassing
{
    var dataStore: MainDataStore? { get }
}

class MainRouter: NSObject, MainRoutingLogic, MainDataPassing
{
    
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
    
    // MARK: Routing
    
    func routeToPopup(segue: UIStoryboardSegue?)
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = viewController
        navigateToPopup(source: viewController!, destination: vc)
    }
    
    func routeToDetail(segue: UIStoryboardSegue?, indexPath: IndexPath) {
        if let segue = segue {
            let destinationVC = segue.destination as! DetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetail(source: dataStore!, destination: &destinationDS, indexPath: indexPath)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetail(source: self.dataStore!, destination: &destinationDS, indexPath: indexPath)
            navigateToDetail(source: viewController!, destination: destinationVC)
        }
    }
    
    
    // MARK: Navigation
    
    func navigateToPopup(source: MainViewController, destination: PopupViewController)
    {
        source.present(destination, animated: true, completion: nil)
    }
    
    func navigateToDetail(source: MainViewController, destination: DetailViewController)
    {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: DetailDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
    
    func passDataToDetail(source: MainDataStore, destination: inout DetailDataStore, indexPath: IndexPath)
    {
        destination.model = source.model[indexPath.item]
    }
}


