//
//  PopupViewController.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 10.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

protocol PopupDisplayLogic: class
{
    func displayTellMain(viewModel: Popup.TellMain.ViewModel)
}

protocol PopupSelectionDelegate: class
{
    func didSelect(type: SearchType)
}


class PopupViewController: UIViewController, PopupDisplayLogic
{
    var interactor: PopupBusinessLogic?
    var router: (NSObjectProtocol & PopupRoutingLogic & PopupDataPassing)?
    
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    var delegate: PopupSelectionDelegate?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = PopupInteractor()
        let presenter = PopupPresenter()
        let router = PopupRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    

    
    // MARK: Do something
    
    @IBAction func okButtonTapped(_ sender: Any) {
        doTellMain()
        self.dismiss(animated: true, completion: nil)
    }
    
    func doTellMain(){
        let media: SearchType
        switch mediaSegmentedControl.selectedSegmentIndex {
        case 0:
            media = .movie
            break
        case 1:
            media = .podcast
            break
        case 2:
            media = .music
            break
        case 3:
            media = .all
            break
        default:
            media = .all
            break
        }
        delegate?.didSelect(type: media)
    }
    
    func displayTellMain(viewModel: Popup.TellMain.ViewModel) {    }
}

