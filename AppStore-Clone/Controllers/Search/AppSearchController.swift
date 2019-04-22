//
//  AppSearchController.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 19/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import SDWebImage

private let cellId = "Cell"

class AppSearchController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var timer : Timer? // for Throtling
    
    let infoLabel : UILabel = {
        let label = UILabel()
        label.text = "Please enter the search term"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    var appResults = [SearchResultApp]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        view.addSubview(infoLabel)
        infoLabel.fillSuperview()
        
        
        collectionView.register(SearchResultAppCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchItuneApps(searchText: "Instagram")
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    
    
    // Search iTune Apps
    fileprivate func fetchItuneApps(searchText : String) {
        APIService.shared.fetchItuneApps(searchText: searchText) { (results, error) in
            if let err = error {
                print("Error : \(err.localizedDescription)")
                return
            }
            self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    // UICollectionView functions
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        infoLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultAppCell
        cell.resultApp = appResults[indexPath.item]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    
}

extension AppSearchController : UISearchBarDelegate {
    
    // Throtling the search
    // Throtling - Throttling is mainly used for the searching tasks whenever a user types fast to make sure that, backend server doesn’t receive multiple requests. if you send multiple requests to the server and canceling the request it increases the load on the server if the server is paid and it also increases the cost too much.
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false, block: { (_) in
            self.fetchItuneApps(searchText: searchText)
        })
        
    }
    
    
    
}



