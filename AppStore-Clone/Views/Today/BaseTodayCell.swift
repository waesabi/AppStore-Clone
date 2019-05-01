//
//  BaseTodayCell.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 01/05/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    
    var todayItem : TodayItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
