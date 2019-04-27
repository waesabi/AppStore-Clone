//
//  AppHorizontalController.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 22/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import SDWebImage

class AppHorizontalController: HorizontalSnappingController {
    
    fileprivate let cellId = "cellId"
    
    var didSelectHandler : ((FeedResult) -> ())?
    
    var appGroup : AppGroup? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = appGroup?.feed.results[indexPath.item]
        print(app?.name ?? "No name")
        if let app = app {
            didSelectHandler?(app)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        if let appGroup = self.appGroup {
            let result = appGroup.feed.results[indexPath.item]
            cell.nameLabel.text = result.name
            cell.companyNameLabel.text = result.artistName
            if let url = URL(string: result.artworkUrl100) {
                cell.appIconImageView.sd_setImage(with: url)
            }
        }
        return cell
    }
    
}

extension AppHorizontalController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 52) / 3
        let width = view.frame.width - 48
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
}
