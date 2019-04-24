//
//  BaseTabBarController.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 19/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarController : UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavigationController(vc: AppsPageController(), title: "Apps", icon: #imageLiteral(resourceName: "apps")),
            createNavigationController(vc: AppSearchController(), title: "Search", icon: #imageLiteral(resourceName: "search")),
            createNavigationController(vc: UIViewController(), title: "Today", icon: #imageLiteral(resourceName: "today_icon"))
        ]
        
    }
    
    
    
    
    fileprivate func createNavigationController(vc : UIViewController, title : String, icon : UIImage) -> UINavigationController {
        vc.navigationItem.title = title
        vc.view.backgroundColor = .white
        let navVC = UINavigationController(rootViewController: vc)
        
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = icon
        navVC.navigationBar.prefersLargeTitles = true
        return navVC
    }
    
    
}

