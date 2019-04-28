//
//  ScreenshotCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 28/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import SDWebImage


class ScreenshotCell: UICollectionViewCell {
    
    let previewImageView = UIImageView(cornerRadius: 16)
    
    var screenShotUrl : String? {
        didSet {
            if let screenShotUrl = screenShotUrl {
                let url = URL(string: screenShotUrl)
                self.previewImageView.sd_setImage(with: url)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        previewImageView.backgroundColor = .red
        addSubview(previewImageView)
        previewImageView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 16, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
