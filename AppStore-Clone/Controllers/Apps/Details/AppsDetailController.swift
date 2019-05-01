//
//  AppsDetailController.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 27/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class AppsDetailController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // Lookup url = https://itunes.apple.com/lookup?id=1152350815
    let cellId = "appDetailCellId"
    let previewCellId = "previewCellId"
    let reviewCellId = "reviewCellId"
    
    var app : SearchResultApp?
    var appReviews : AppReview?
    fileprivate let appId : String
    
    // Dependency Injection
    init(appId : String) {
        self.appId = appId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        collectionView.backgroundColor = .white
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
        
        fetchData()
        
    }
    
    fileprivate func fetchData() {
        APIService.shared.fetchAppDetail(appId: appId) { (searchResult, error) in
            if let error = error {
                print("Failed to fetch app detials - \(error.localizedDescription)")
                return
            }
            self.app = searchResult?.results.first
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        APIService.shared.fetchAppReviews(appId: appId) { (appReviews, error) in
            if let error = error {
                print("Failed to fetch app detials - \(error.localizedDescription)")
                return
            }
            self.appReviews = appReviews
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailCell
            cell.searchResultApp = self.app
            return cell
        }
        else if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.previewController.app = self.app
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
            cell.reviewsController.appReviews = self.appReviews
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height : CGFloat = 250
        if indexPath.item == 0 {
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            
            dummyCell.searchResultApp = self.app
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            height = estimatedSize.height
            
        }
        else if indexPath.item == 1{
            height = 500
        }
        else {
            height = 250
        }
        return .init(width: view.frame.width, height: height)
    }
    
}
