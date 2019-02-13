//
//  PopupRouter.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 10.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

@objc protocol PopupRoutingLogic
{
    //    func routeToMain(segue: UIStoryboardSegue?)
}

protocol PopupDataPassing
{
    var dataStore: PopupDataStore? { get }
}

class PopupRouter: NSObject, PopupRoutingLogic, PopupDataPassing
{
    weak var viewController: PopupViewController?
    var dataStore: PopupDataStore?
    
    // MARK: Routing
    
    //    func routeToMain(segue: UIStoryboardSegue?)
    //    {
    //
    //    }
    
    // MARK: Navigation
    
    //    func navigateToMain(source: PopupViewController, destination: MainViewController)
    //    {
    //        //    source.show(destination, sender: nil)
    //        source.dismiss(animated: true, completion: nil)
    
    //    }
    
    // MARK: Passing data
    
    //    func passDataToMain(source: PopupDataStore, destination: inout MainDataStore)
    //    {
    //        //    destination.media = source.media
    //    }
}



