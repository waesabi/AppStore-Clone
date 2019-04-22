//
//  AppRowCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 22/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let nameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 16))
    let companyNameLabel = UILabel(text: "Facebook.inc", font: .systemFont(ofSize: 13))
    let appIconImageView = UIImageView(cornerRadius: 15)
    let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
