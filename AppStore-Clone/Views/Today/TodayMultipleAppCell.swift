//
//  TodayMultipleAppCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 01/05/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
    override var todayItem : TodayItem! {
        didSet  {
            categoryLabel.text = todayItem?.category
            titleLabel.text = todayItem?.title
            multipleAppsController.feedResult = todayItem.apps
            multipleAppsController.collectionView.reloadData()
        }
    }
    
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 12))
    let titleLabel = UILabel(text: "Utilizing Your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 0)
    
    
    let multipleAppsController = TodayMultipleAppsController(mode: .small)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        
        categoryLabel.constrainHeight(constant: 24)
        
        let stackView = VerticalStackView(arrangeSubviews: [
            categoryLabel,
            titleLabel,
            multipleAppsController.view!
            ], spacing: 4)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
