//
//  Navigator.swift
//  KadabraDigital
//
//  Created by Mahmoud Alaa on 12/02/2021.
//

import UIKit

enum NavigationTypes{
    case push(animated: Bool)
    case present(animated: Bool)
    case tabBarPush(animated: Bool)
    case root
}

protocol Navigator {
    associatedtype Destination

    func viewController(for destination: Destination) -> UIViewController
    
    var coordinator: Coordinator {get}
    init(coordinator: Coordinator)
    
    func navigate(to destination: Destination, with navigationType: NavigationTypes)
    func popTo(to destination: Destination)
}

extension Navigator{
    func navigate(to destination: Destination, with navigationType: NavigationTypes = .push(animated: true)){
        let viewController = self.viewController(for: destination)
        switch navigationType {
        case let .tabBarPush(animated):
            coordinator.tabBarSelectedItemNavigation?.pushViewController(viewController, animated: animated)
        case let .push(animated):
            coordinator.navigationController.pushViewController(viewController, animated: animated)
        case let .present(animated):
            coordinator.navigationController.present(viewController, animated: animated, completion: nil)
        case .root:
            coordinator.navigationController.setViewControllers([viewController], animated: true)
        }
    }
    
    func popTo(to destination: Destination){
        let type: AnyClass = self.viewController(for: destination).classForCoder
        if let controller = self.coordinator.navigationController.viewControllers.first(where: {$0.isKind(of: type)}){
            self.coordinator.navigationController.popToViewController(controller, animated: true)
        }
    }
    
}
