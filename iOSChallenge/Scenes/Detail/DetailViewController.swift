//
//  DetailViewController.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

protocol DetailDisplayLogic: class
{
    func displaySearchDetail(viewModel: Detail.SearchDetail.ViewModel)
}

protocol DetailDeleteDelegate: class
{
    func didTapDelete(trackId: Int)
}

class DetailViewController: UIViewController, DetailDisplayLogic
{
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    var delegate: DetailDeleteDelegate?
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
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
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
        doSomething()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func deleteBarButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to delete?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.router?.routeToMain(segue: nil)
            print("Deleted")
        }))
        self.present(alert, animated: true)
    }
    
    func doSomething()
    {
        let request = Detail.SearchDetail.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySearchDetail(viewModel: Detail.SearchDetail.ViewModel)
    {
        titleLabel.text = viewModel.model.title
        searchImageView.loadImage(urlString: viewModel.model.imagePath!)
        descriptionLabel.text = viewModel.model.description
    }
}

