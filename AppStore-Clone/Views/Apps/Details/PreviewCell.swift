//
//  PreviewCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 28/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 24))
    let previewController = PreviewScreenshotController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // backgroundColor = UIColor(white: 0.95, alpha: 1)
        addSubview(previewLabel)
        previewLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        addSubview(previewController.view)
        previewController.view.anchor(top: previewLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
