//
//  FavouriteVC.swift
//  IOS Task Trend
//
//  Created by Apple on 2/4/22.
//

import UIKit

class FavouriteVC: BaseViewController<FavouriteViewModel> {

    @IBOutlet weak var collectionView : UICollectionView!

    

    lazy var collectionViewFlowLayout : CustomCollectionViewFlowLayout = {
        let layout = CustomCollectionViewFlowLayout(display: .list, containerWidth: self.view.bounds.width)
        return layout
    }()
    
    lazy var dataSource :FavouitesDataSource = {
        let d = FavouitesDataSource(favBehaviour: self)
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UINib(nibName: "\(ImageCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ImageCollectionViewCell.self)")
        self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
        self.collectionView.dataSource = self.dataSource
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
        }
        initViewModel()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initFetch()

    }
    override func bind(viewModel: FavouriteViewModel) {
        
    }
    private func initViewModel() {
        
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.dataSource.data.value = self?.viewModel.imagesInFav ?? []
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func initFetch() {
        viewModel.getImagesInFav()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.reloadCollectionViewLayout(self.view.bounds.size.width)
    }
    
    private func reloadCollectionViewLayout(_ width: CGFloat) {
     
        self.collectionViewFlowLayout.containerWidth = width
        self.collectionViewFlowLayout.display =   CollectionDisplay.list 
     
    }
}
extension FavouriteVC:FavouriteActionDelegate{
    func addFav(fav: Favourites) {
        
    }
    
    func removeFav(fav: Favourites) {
        viewModel.removeFav(fav: fav)
    }
    
    
}
