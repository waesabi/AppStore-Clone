//
//  AppDetailCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 27/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import SDWebImage

class AppDetailCell: UICollectionViewCell {
    
    
    var searchResultApp : SearchResultApp? {
        didSet {
            appNameLabel.text = searchResultApp?.trackName
            artistLabel.text = searchResultApp?.artistName
            priceLabelButotn.setTitle(searchResultApp?.formattedPrice, for: .normal)
            releaseNoteLabel.text = searchResultApp?.releaseNotes
            
            if let urlString = searchResultApp?.artworkUrl100 {
                appIconImageView.sd_setImage(with: URL(string: urlString))
            }
            
        }
    }
    
    
    let appIconImageView = UIImageView(cornerRadius: 16)
    let appNameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let artistLabel = UILabel(text: "Facebook", font: .systemFont(ofSize: 16))
    let priceLabelButotn = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(text: "What's New.", font: .boldSystemFont(ofSize: 16))
    
    let releaseNoteLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appIconImageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        appIconImageView.constrainWidth(constant: 100)
        appIconImageView.constrainHeight(constant: 120)
        
        artistLabel.textColor = .lightGray
        
        priceLabelButotn.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.5921568627, blue: 0.9411764706, alpha: 1)
        priceLabelButotn.setTitleColor(.white, for: .normal)
        priceLabelButotn.constrainWidth(constant: 80)
        priceLabelButotn.layer.cornerRadius = 17
        priceLabelButotn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        let appInfoVerticalStackView = VerticalStackView(arrangeSubviews: [
            appNameLabel,
            artistLabel,
            UIStackView(arrangedSubviews: [priceLabelButotn,UIView()])
            ], spacing: 2)
        
        
        let horizontalStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            appInfoVerticalStackView
            ])
        
        horizontalStackView.spacing = 16
        
        let stackView = VerticalStackView(arrangeSubviews: [
            horizontalStackView,
            whatsNewLabel,
            releaseNoteLabel
            ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
