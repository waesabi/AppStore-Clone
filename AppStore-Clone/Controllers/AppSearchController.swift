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

class AppSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var appResults = [SearchResultApp]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultAppCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchItuneApps()
    }
    
    
    fileprivate func fetchItuneApps() {
        APIService.shared.fetchItuneApps { (results, error) in
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
    
    // Initialization of Collection View
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UICollectionView functions
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultAppCell
        let res = appResults[indexPath.item]
        cell.resultApp = res
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    
}
