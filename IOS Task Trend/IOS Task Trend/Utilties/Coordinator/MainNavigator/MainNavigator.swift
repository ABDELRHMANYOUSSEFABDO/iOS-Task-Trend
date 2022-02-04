//
//  MainNavigator.swift
//  KadabraDigital
//
//  Created by Mahmoud Alaa on 12/02/2021.
//

import Foundation
import UIKit
class MainNavigator: Navigator{
    
    var coordinator: Coordinator
    
    enum Destination {
        
        //MARK:- General
        case tabBar
        case home
        case search
        case favourite
       
        
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .tabBar:
            return coordinator.tabBarController
        case .home:
            break
        case .favourite:
            break
        case .search:
            break
        }
        return .init()
    }
    
}
