//
//  TabBarController.swift
//  IOS Task Trend
//
//  Created by Apple on 2/4/22.
//

import UIKit

class TabBarController: UITabBarController{
    
    var coordinator: Coordinator
    
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum TabBarItems: Int, CaseIterable{
        case Home
        case favourite
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarItem()
        self.setupTabBarStyle()
        self.delegate = self
    }
    
    private func setupTabBarItem(){
        self.viewControllers = TabBarItems.allCases.map({
            let viewController = self.viewControllerForTabBarItem(item: $0)
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.isHidden = true
            return navigationController
        })
        self.coordinator.tabBarSelectedItemNavigation = (self.viewControllers?.first as? UINavigationController)
    }
    
    private func viewControllerForTabBarItem(item: TabBarItems)->UIViewController{
        switch item{
        case .Home:
            let viewController = coordinator.mainNavigator.viewController(for: .home)
            viewController.tabBarItem = self.tabBarItemFor(item: item)
            return viewController
        case .favourite:
            let viewController = coordinator.mainNavigator.viewController(for: .favourite)
            viewController.tabBarItem = self.tabBarItemFor(item: item)
            return viewController
        }
       
    }
    
    private func tabBarItemFor(item: TabBarItems)->UITabBarItem{
        let tabBarItem: UITabBarItem
        switch item{
        case .Home:
            let image: UIImage? = UIImage(systemName: "homekit")
            tabBarItem = .init(title: "Home", image: image, selectedImage: image)
        case .favourite:
            let image: UIImage? = UIImage(systemName: "folder")
            tabBarItem = .init(title: "Favourite", image: image, selectedImage: image)
        }
        tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        tabBarItem.imageInsets = .init(top: 0, left: 0, bottom: -10, right: 0)
        
        return tabBarItem
    }
    
    private func setupTabBarStyle(){
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.layer.cornerRadius = 15
        self.tabBar.layer.masksToBounds = true
    }
    
}


extension TabBarController: UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.coordinator.tabBarSelectedItemNavigation = (viewController as? UINavigationController)
    }
    
}
