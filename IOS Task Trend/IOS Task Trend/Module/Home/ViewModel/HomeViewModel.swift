//
//  HomeViewModel.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import Foundation
import Alamofire
import UIKit

class HomeViewModel : BaseViewModel {
    enum LoadMoreStatus {
        case loading
        case finished
        case haveMore
    }
    var ImageElementCellViewModels: [ImageElement] = [ImageElement]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    var reloadCollectionViewClosure: (()->())?
    func fetchPendingImage(){
        self.loadingState = .loading
        NetworkClient.shared.createRequest(router: UnSplash.homeImages as! APIRouter, with: [ImageElement].self) { (data) in
            self.loadingState = .populated
            self.ImageElementCellViewModels = data ?? []
        } returnError: { (error) in
            self.loadingState = .error
        }

    }
    func addFav(fav:Favourites){
        
        DatabaseManager.shared.add(favourites: fav) {[weak self] (success) in
            print("Succes",success)
            guard let self = self else{return}
            self.reloadCollectionViewClosure?()
        }
    }
    func removeFav(fav:Favourites){
        DatabaseManager.shared.remove(favourite: fav)
    }
}
