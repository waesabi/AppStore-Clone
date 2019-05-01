//
//  TodaysAppDetailController.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 30/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class TodaysAppDetailController: UITableViewController {
    
    let cellId = "cellId"
    
    var todayItem : TodayItem?
    
    var dismissHandler : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TodaysAppDetailTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = TodaysAppDetailHeaderView()
            headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            headerCell.todayCell.todayItem = self.todayItem
            headerCell.todayCell.layer.cornerRadius = 0
            return headerCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodaysAppDetailTableViewCell
        return cell
    }
    
    @objc fileprivate func handleDismiss(button : UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}
