//
//  AppsHeaderCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 23/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "Facebook", font: .systemFont(ofSize: 16))
    let descriptionLabel = UILabel(text: "Keeping with friends is faster than ever", font: .systemFont(ofSize: 24))
    let iconImageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         backgroundColor = .white
        
        iconImageView.backgroundColor = .green
        companyLabel.textColor = .blue
        
        let stackView = VerticalStackView(arrangeSubviews: [
            companyLabel,
            descriptionLabel,
            iconImageView
            ], spacing: 12)
        
        addSubview(stackView)
        descriptionLabel.numberOfLines = 2
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 16, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
