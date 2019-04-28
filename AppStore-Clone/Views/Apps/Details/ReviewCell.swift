//
//  ReviewCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 28/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    var appReviewEntry : ReviewEntry?  {
        didSet {
            authorLabel.text = appReviewEntry?.author.name.label
            titleLabel.text = appReviewEntry?.title.label
            reviewLabel.text = appReviewEntry?.content.label
        }
    }
    
    let titleLabel = UILabel(text: "Fix few bugs.", font: .boldSystemFont(ofSize: 16), numberOfLines: 0)
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let ratingLabel = UILabel(text: "⭐️⭐️⭐️", font: .systemFont(ofSize: 14))
    let reviewLabel = UILabel(text: "Review Body \nReview Body \nReview Body", font: .systemFont(ofSize: 14), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let uiview = UIView()
        uiview.backgroundColor = .red
        
        let horizontalStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            authorLabel
            ])
        horizontalStackView.spacing = 4
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        
        let stackView = VerticalStackView(arrangeSubviews: [
            horizontalStackView,
            ratingLabel,
            reviewLabel
            ], spacing: 4)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
