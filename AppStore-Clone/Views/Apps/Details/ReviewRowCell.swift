//
//  ReviewRowCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 28/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
   
    let reviewHeadingLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 24))
    let reviewsController = ReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(reviewHeadingLabel)
        reviewHeadingLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16))
        
        addSubview(reviewsController.view)
        reviewsController.view.anchor(top: reviewHeadingLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
