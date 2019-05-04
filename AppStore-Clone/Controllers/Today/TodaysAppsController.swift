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
    
//    let items : [TodayItem] = [
//        TodayItem(category: "THE DAILY LIST", title: "Test-Drive These Cool Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple),
//        TodayItem(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to inteligently organize your life the right way.", backgroundColor: .white, cellType: .single),
//        TodayItem(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9841833711, green: 0.9656425118, blue: 0.7242308259, alpha: 1), cellType: .single)
//    ]
    
    var items = [TodayItem]()
    let activityIndicatorView : UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .whiteLarge)
        loadingView.startAnimating()
        loadingView.color = .darkGray
        loadingView.hidesWhenStopped = true
        return loadingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(TodaysCell.self, forCellWithReuseIdentifier: CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: CellType.multiple.rawValue)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        fetchApps()
    }
    
    var topGrossingAppGroup : AppGroup?
    var gamesGroup : AppGroup?
    // Dispatch Group
    fileprivate func fetchApps() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIService.shared.fetchTopGrossing { (appGroup, error) in
            dispatchGroup.leave()
            if let err = error {
                print("Failed to fetch top grossing app : \(err.localizedDescription)")
                return
            }
            self.topGrossingAppGroup = appGroup
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchGames { (appGroup, error) in
            dispatchGroup.leave()
            if let err = error {
                print("Failed to fetch top grossing app : \(err.localizedDescription)")
                return
            }
            self.gamesGroup = appGroup
        }
        
        // Completion of dispatch group
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            
            self.items = [
                TodayItem(category: "DAILY APPS LIST", title: self.topGrossingAppGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: self.topGrossingAppGroup?.feed.results ?? []),
                TodayItem(category: "DAILY GAMES LIST", title: self.gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: self.gamesGroup?.feed.results ?? []),
                TodayItem(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9841833711, green: 0.9656425118, blue: 0.7242308259, alpha: 1), cellType: .single, apps: [])
                
            ]
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.superview?.setNeedsLayout()
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
        
        (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        return cell
    }
    
    @objc fileprivate func handleMultipleAppsTap(gesture : UITapGestureRecognizer) {
        let collectionView = gesture.view
        
        var superView = collectionView?.superview
        while superView != nil {
            if let cell = superView as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                let apps = self.items[indexPath.item].apps
                let controller = TodayMultipleAppsController(mode: .fullScreen)
                controller.feedResult = apps
                present(controller, animated: true)
                return 
            }
            superView = superView?.superview
        }
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
        
        
        if self.items[indexPath.item].cellType == .multiple {
            let redVC = TodayMultipleAppsController(mode: .fullScreen)
            redVC.feedResult = self.items[indexPath.item].apps
            present(BackEnabledNavigationController(rootViewController: redVC), animated: true, completion: nil)
            return
        }
        
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
