//
//  ImageDataSource.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import Foundation
import UIKit
import RealmSwift
import SDWebImage
class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
protocol ZoomImageButtonDelegate {
    func zoomImageButtonIsPressed(imageURL: String)
}
class ImageDataSource : GenericDataSource<ImageElement>, UICollectionViewDataSource,UICollectionViewDelegate {
    var zoomImageButtonDelegate: ZoomImageButtonDelegate?
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
        cell.setupCell(data:data.value[indexPath.row])
    
        cell.didFavActionPressed = {[weak self] isFav in
            guard let self = self else{return }
            guard let fav = cell.fav else{return}
            DispatchQueue.main.async {
                isFav ? self.favBehaviour.addFav(fav:fav) : self.favBehaviour.removeFav(fav: fav)

            }
        }
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf:  url!) {
//                       if let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            cell.image.image = image
//                        }
//                       }
//                   }
//               }
        
          
    return cell
    }
    func zoomImageButtonIsPressed(imageURL: String) {
        if let delegateValue = zoomImageButtonDelegate {
            delegateValue.zoomImageButtonIsPressed(imageURL: imageURL)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let image = data.value[indexPath.row].urls?.regular{
            zoomImageButtonIsPressed(imageURL: image)
        }
    }
    
}
