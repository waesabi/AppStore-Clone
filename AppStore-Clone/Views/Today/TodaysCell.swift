//
//  TodaysCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 29/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class TodaysCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 250, height: 250))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
