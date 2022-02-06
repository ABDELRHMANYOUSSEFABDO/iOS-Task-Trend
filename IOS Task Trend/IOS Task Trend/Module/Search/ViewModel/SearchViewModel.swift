//
//  SearchViewModel.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import Foundation
class SearchViewModel:BaseViewModel{
     var query:String
     init(query:String) {
        self.query = query
        super.init()
    }
    
    private func getSearchImages(){
        
    }
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
        NetworkClient.shared.createRequest(router: UnSplash.searchImages(query: query), with: SearchResponseModel.self) { (data) in
            self.loadingState = .populated
            self.ImageElementCellViewModels = data?.results ?? []
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

