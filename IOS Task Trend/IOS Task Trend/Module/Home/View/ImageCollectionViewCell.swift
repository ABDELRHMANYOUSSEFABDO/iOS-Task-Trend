//
//  ImageCollectionViewCell.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
typealias isFav = Bool
    @IBOutlet var image: UIImageView!
    @IBOutlet var nameImage: UILabel!
    @IBOutlet var addFavButton: UIButton!
    private(set) var fav:Favourites?
    let imageViewModel = ImageFavViewModel()
    var didFavActionPressed:((isFav)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(data:ImageElement){
        let url = URL(string: data.urls!.regular)
      image.sd_setImage(with: url, completed: nil)
        fav = .init(title:"", image: data.urls?.regular ?? "", id: data.id ?? "")
       let favImage = imageViewModel.isImageInFav(fav: fav!) ?  #imageLiteral(resourceName: "favourite") :  #imageLiteral(resourceName: "unfavourite")
        addFavButton.setImage(favImage, for: .normal)
    }
    func setupCellfav(data:Favourites){
        let url = URL(string: data.originalImageUrlString)
      image.sd_setImage(with: url, completed: nil)
        fav = data
       let favImage = imageViewModel.isImageInFav(fav: fav!) ?  #imageLiteral(resourceName: "favourite") :  #imageLiteral(resourceName: "unfavourite")
        addFavButton.setImage(favImage, for: .normal)
    }
    @IBAction func favActionPressed(_ sender: Any) {
        let isFav = !imageViewModel.isImageInFav(fav: fav!)
        addFavButton.setImage(isFav ?  #imageLiteral(resourceName: "favourite") :  #imageLiteral(resourceName: "unfavourite"), for: .normal) 
            self.didFavActionPressed?(isFav)
    }
}

class ImageFavViewModel{
    private(set) var isExist = false
    func isImageInFav(fav:Favourites)->Bool{
        isExist = DatabaseManager.shared.isFavExist(fav: fav)
        return isExist
    }
}
