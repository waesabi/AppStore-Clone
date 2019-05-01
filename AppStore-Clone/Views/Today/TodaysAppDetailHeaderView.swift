//
//  TodaysAppDetailHeaderView.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 01/05/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class TodaysAppDetailHeaderView: UITableViewCell {
    
    let todayCell = TodaysCell()
    
    let closeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(todayCell)
        todayCell.fillSuperview()
        
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 32))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
