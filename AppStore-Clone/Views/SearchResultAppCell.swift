//
//  SearchResultAppCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 19/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class SearchResultAppCell: UICollectionViewCell {
    
    
    var resultApp : SearchResultApp! {
        didSet {
            appNameLabel.text = resultApp.trackName
            appCategoryLabel.text = resultApp.primaryGenreName
            ratingsLabel.text = "Rating : \(resultApp.averageUserRating ?? 0)"
            let url = URL(string: resultApp.artworkUrl100)
            appIconImageView.sd_setImage(with: url)
            
            let screenshotCount = resultApp.screenshotUrls.count
            let screenshotUrls = resultApp.screenshotUrls
            
            screenshotImageView_1.sd_setImage(with: URL(string: screenshotUrls[0]))
            
            if screenshotCount > 1 {
                screenshotImageView_2.sd_setImage(with: URL(string: screenshotUrls[1]))
            }
            
            if screenshotCount > 2 {
                screenshotImageView_3.sd_setImage(with: URL(string: screenshotUrls[2]))
            }
        }
    }
    
    let appIconImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
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
//        label.textColor = .darkGray
        return label
    }()
    
    let ratingsLabel : UILabel = {
        let label = UILabel()
        label.text = "4.3M"
        return label
    }()
    
    
    let getButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
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
        // imageView.layer.borderWidth = 0.5
        // imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.3).cgColor
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
