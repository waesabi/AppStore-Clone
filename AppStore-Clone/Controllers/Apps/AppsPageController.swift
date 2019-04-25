//
//  AppsPageController.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 22/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit


class AppsPageController: BaseCollectionViewController , UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .black
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppGroupCell.self, forCellWithReuseIdentifier: cellId)
        
        // Register header view
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        // Add Indicator View
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    var group = [AppGroup]()
    var socialApps = [SocialApp]()
    
    fileprivate func fetchData() {
        print("Fetching the data...")
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIService.shared.fetchGames { (appGroup, error) in
            dispatchGroup.leave()
            if let err = error {
                print("Failed to fetch games : ", err.localizedDescription)
                return
            }
            if let appGroup = appGroup {
                self.group.append(appGroup)
            }
        }
        dispatchGroup.enter()
        APIService.shared.fetchTopGrossing { (appGroup, error) in
            dispatchGroup.leave()
            if let err = error {
                print("Failed to top grossing : ", err.localizedDescription)
                return
            }
            if let appGroup = appGroup {
                self.group.append(appGroup)
            }
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchTopFree { (appGroup, error) in
            dispatchGroup.leave()
            if let err = error {
                print("Failed to top free : ", err.localizedDescription)
                return
            }
            if let appGroup = appGroup {
                self.group.append(appGroup)
            }
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchSocialApps { (socialApps, error) in
            dispatchGroup.leave()
            if let err = error {
                print("Failed to top free : ", err.localizedDescription)
                return
            }
            self.socialApps = socialApps ?? []
            socialApps?.forEach({print($0.name)})
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.appHeaderController.socialApps = socialApps
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppGroupCell
        let appGroup = self.group[indexPath.item]
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        // cell.horizontalController.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}
