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
        case search(query:String)
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
            let homeViewModel = HomeViewModel()
            let homeVC = HomeVC(viewModel: homeViewModel, coordinator: self.coordinator)
                return homeVC
        case .favourite:
            return FavouriteVC()
            
        case .search(let query):
            let searchViewModel = SearchViewModel(query: query)
            return  SearchVC(viewModel: searchViewModel, coordinator: coordinator)
        
    }
    
}
}
