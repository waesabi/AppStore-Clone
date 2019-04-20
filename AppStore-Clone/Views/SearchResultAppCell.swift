//
//  SearchResultAppCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 19/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class SearchResultAppCell: UICollectionViewCell {
    
    let appIconImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    let appNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Tik Tok"
        return label
    }()
    
    let appCategoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Social Media"
        return label
    }()
    
    let ratingsLabel : UILabel = {
        let label = UILabel()
        label.text = "4.3M"
        return label
    }()
    
    
    let getButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.setTitle("GET", for: .normal)
        button.layer.cornerRadius = 15
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    
    lazy var screenshotImageView_1 = self.createImageView()
    lazy var screenshotImageView_2 = self.createImageView()
    lazy var screenshotImageView_3 = self.createImageView()
    
    fileprivate func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        let lablesStackView = VerticalStackView(arrangeSubviews: [
                appNameLabel,
                appCategoryLabel,
                ratingsLabel
            ]
            , spacing: 1)
        
        
        let infoStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            lablesStackView,
            getButton
            ]
        )
        infoStackView.spacing = 12
        infoStackView.alignment = .center
        
        
        let screenshotStackView = UIStackView(arrangedSubviews: [
            screenshotImageView_1,
            screenshotImageView_2,
            screenshotImageView_3
            ])
        screenshotStackView.spacing = 16
        screenshotStackView.distribution = .fillEqually
        
        let overallStackView = UIStackView(arrangedSubviews: [
            infoStackView,
            screenshotStackView
            ])
        overallStackView.spacing = 16
        overallStackView.axis = .vertical
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
