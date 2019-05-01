//
//  TodaysAppsController.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 29/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class TodaysAppsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let multipleAppCellId = "multipleCellId"
    
    let items : [TodayItem] = [
        TodayItem(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to inteligently organize your life the right way.", backgroundColor: .white, cellType: .single),
        TodayItem(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9841833711, green: 0.9656425118, blue: 0.7242308259, alpha: 1), cellType: .single),
        TodayItem(category: "THE DAILY LIST", title: "Test-Drive These Cool Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(TodaysCell.self, forCellWithReuseIdentifier: CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: CellType.multiple.rawValue)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Multiple App Cell
        
        let item = self.items[indexPath.item]
        let cellType = item.cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType, for: indexPath) as! BaseTodayCell
        cell.todayItem = item
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: 500)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    var todaysAppDetailController : TodaysAppDetailController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected....")
        let todaysAppDetailController = TodaysAppDetailController()
        todaysAppDetailController.todayItem = self.items[indexPath.row]
        todaysAppDetailController.dismissHandler = {
            self.handleRemoveRedView()
        }
        let appDetailScreen = todaysAppDetailController.view!
        
        appDetailScreen.layer.cornerRadius = 16
        view.addSubview(appDetailScreen)
        addChild(todaysAppDetailController)
        self.todaysAppDetailController = todaysAppDetailController
        self.collectionView.isUserInteractionEnabled = false
        self.todaysAppDetailController.tableView.contentOffset = .zero
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return  }
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return  }
        self.startingFrame = startingFrame
        
        // Anchor
        appDetailScreen.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = appDetailScreen.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = appDetailScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = appDetailScreen.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = appDetailScreen.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
        
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            guard let cell = self.todaysAppDetailController.tableView.cellForRow(at: [0,0]) as? TodaysAppDetailHeaderView else { return }
            cell.todayCell.topConstaint?.constant = 48
            cell.layoutIfNeeded()
        })
        
    }
    
    var startingFrame : CGRect?
    @objc fileprivate func handleRemoveRedView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.todaysAppDetailController.tableView.contentOffset = .zero
            guard let startingFrame = self.startingFrame else { return }
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.tabBarController?.tabBar.transform = .identity
            guard let cell = self.todaysAppDetailController.tableView.cellForRow(at: [0,0]) as? TodaysAppDetailHeaderView else { return }
            cell.todayCell.topConstaint?.constant = 24
            cell.layoutIfNeeded()
        }, completion: { _ in
            self.todaysAppDetailController.view.removeFromSuperview()
             self.todaysAppDetailController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
        
    }
    
}
