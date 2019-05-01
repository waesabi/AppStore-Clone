//
//  MultiplaAppCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 01/05/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import SDWebImage

class MultiplaAppCell: UICollectionViewCell {
    
    var feedResult : FeedResult? {
        didSet {
            nameLabel.text = feedResult?.name
            companyNameLabel.text = feedResult?.artistName
            if let url = URL(string: feedResult?.artworkUrl100 ?? "") {
                appIconImageView.sd_setImage(with: url)
            }
            
        }
    }
    
    let nameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 16))
    let companyNameLabel = UILabel(text: "Facebook.inc", font: .systemFont(ofSize: 13))
    let appIconImageView = UIImageView(cornerRadius: 15)
    let getButton = UIButton(title: "GET")
    let saparatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
         view.constrainHeight(constant: 0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel.numberOfLines = 2
        appIconImageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        appIconImageView.constrainWidth(constant: 64)
        appIconImageView.constrainHeight(constant: 64)
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 36)
        getButton.layer.cornerRadius = 18
        getButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        
        let stackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            VerticalStackView(arrangeSubviews: [
                nameLabel,
                companyNameLabel
                ], spacing: 3),getButton
            ])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
        
        addSubview(saparatorView)
        saparatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
