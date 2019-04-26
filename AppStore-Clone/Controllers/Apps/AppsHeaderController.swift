//
//  AppsHeaderController.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 23/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class AppsHeaderController: HorizontalSnappingController , UICollectionViewDelegateFlowLayout{
    
    fileprivate let cellId = "cellId"
    
    var socialApps : [SocialApp]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
        if let socialApps = self.socialApps {
            let app = socialApps[indexPath.item]
            cell.socialApp = app
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 48, height: view.frame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 8, left: 16, bottom: 8, right: 16)
//    }
    
    
    
}
