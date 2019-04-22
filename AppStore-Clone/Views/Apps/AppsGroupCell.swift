//
//  AppsGroupCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 22/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text : String , font : UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        
    }
}

class AppGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "App Section", font: UIFont.boldSystemFont(ofSize: 30))
    
    
    let horizontalController = AppHorizontalController()
    
    
    
//    let titleLabel : UILabel = {
//        let label = UILabel()
//        label.text = "App Section"
//        label.font = UIFont.systemFont(ofSize: 30)
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
