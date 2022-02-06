//
//  FavouriteViewModel.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import Foundation
import Alamofire
import UIKit

class FavouriteViewModel : BaseViewModel {
    enum LoadMoreStatus {
        case loading
        case finished
        case haveMore
    }

    

    var imagesInFav: [Favourites] = [Favourites]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    var reloadCollectionViewClosure: (()->())?
   
    
    func getImagesInFav(){
      imagesInFav =  DatabaseManager.shared.getAllFav()

    }

    func removeFav(fav:Favourites){
        DatabaseManager.shared.remove(favourite: fav)
        getImagesInFav()
    }
}
