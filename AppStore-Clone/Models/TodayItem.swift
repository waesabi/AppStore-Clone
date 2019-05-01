//
//  TodayItem.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 01/05/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

enum CellType : String {
    case single
    case multiple
}

struct TodayItem {
    let category : String
    let title : String
    let image : UIImage
    let description : String
    let backgroundColor : UIColor
    let cellType : CellType
    let apps : [FeedResult]
    
    
}

// TodayItem(category: "THE DAILY LIST", title: "Test-Drive These Cool Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white)
