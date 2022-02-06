//
//  FavouitesDataSource.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import Foundation
import UIKit
import RealmSwift
import SDWebImage

class FavouitesDataSource : GenericDataSource<Favourites>, UICollectionViewDataSource {
    
    private let favBehaviour:FavouriteActionDelegate!
    init(favBehaviour:FavouriteActionDelegate) {
        self.favBehaviour = favBehaviour
        super.init()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell)!
        cell.setupCellfav(data: data.value[indexPath.row])
        cell.didFavActionPressed = {[weak self] isFav in
            guard let self = self else{return }
            guard let fav = cell.fav else{return}
            DispatchQueue.main.async {
                isFav ? self.favBehaviour.addFav(fav:fav) : self.favBehaviour.removeFav(fav: fav)

            }
        }
          
    return cell
    }
   
    
}
