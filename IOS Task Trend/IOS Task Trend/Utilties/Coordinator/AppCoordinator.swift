//
//  AppCoordinator.swift
//  IOS Task Trend
//
//  Created by Apple on 2/4/22.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    var navigationController: UINavigationController! { get }
    var tabBarSelectedItemNavigation: UINavigationController? { get set}
    var mainNavigator: MainNavigator { get }
    var tabBarController: UITabBarController {get}
}

class AppCoordinator: Coordinator{
    
    var navigationController: UINavigationController!
    let window: UIWindow
    
    lazy var mainNavigator: MainNavigator = {
        return .init(coordinator: self)
    }()
    
    
    var tabBarSelectedItemNavigation: UINavigationController?
    
    var tabBarController: UITabBarController{
        get{
            return TabBarController(coordinator: self)
        }
    }

    var rootViewController: UIViewController{
        let navigationController = UINavigationController(rootViewController: self.mainNavigator.viewController(for: .tabBar))
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
        return navigationController
    }
    
    init(window: UIWindow = UIWindow()) {
        self.window = window
        self.window.backgroundColor = .white
    }
    
    func start(){
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
}
