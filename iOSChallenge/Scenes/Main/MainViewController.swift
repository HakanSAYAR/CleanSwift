//
//  MainViewController.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright (c) 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: class
{
    func displaySearchResults(viewModel: Main.Search.ViewModel)
    func displayDelete(index: Int)
}

class MainViewController: UIViewController, MainDisplayLogic
{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    var lastSearchType : SearchType = SearchType.movie
    var searchText : String = ""
    var items: [SearchListViewModel] = []
    var searchResultCount: Int = 0
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
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchResults(searchType: lastSearchType, searchText: "all")
    }
    
    // MARK: Do something
    
    @IBAction func mediaButtonTapped(_ sender: Any) {
        router?.routeToPopup(segue: nil)
        
    }
    func searchResults(searchType: SearchType, searchText: String)
    {
        let model = SearchRequestModel(media: searchType, entity: searchType, limit: 100, term: searchText)
        let request = Main.Search.Request(model: model)
        interactor?.doSearchResults(request: request)
    }
    
    func displaySearchResults(viewModel: Main.Search.ViewModel) {
        self.items = viewModel.model
        collectionView.reloadData()
    }
    
    func displayDelete(index: Int) {
        items.remove(at: index)
        collectionView.deleteItems(at: [IndexPath.init(item: index, section: 0)])
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResultCount = items.count
        if searchResultCount > 0 {
            return items.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if searchResultCount > 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCell
            cell.configure(with: items[indexPath.item])
            return cell
        }else {
            let empty_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoResultCell", for: indexPath) as! NoResultCell
            return getEmptyCell(empty_cell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.interactor?.doSelectItem(index: indexPath.item)
        self.router?.routeToDetail(segue: nil, indexPath: indexPath)
    }
    
    func getEmptyCell(_ empty_cell: NoResultCell) -> NoResultCell{
        let text = self.searchText
        if !text.isEmpty{
            empty_cell._text = String.init(format: "Sorry, we couldn't find any result for \"%2$@\"", text);
        }
        return empty_cell
    }
}

extension MainViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText.isEmpty ? "all" : searchText
        searchResults(searchType: lastSearchType, searchText: self.searchText)
        collectionView.reloadData()
    }
}

extension MainViewController: PopupSelectionDelegate{
    func didSelect(type: SearchType) {
        print(type)
        lastSearchType = type
        searchResults(searchType: lastSearchType, searchText: searchText.isEmpty ? "all" : searchText)
    }
}


