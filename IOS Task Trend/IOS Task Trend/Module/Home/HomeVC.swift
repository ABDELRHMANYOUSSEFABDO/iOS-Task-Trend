//
//  HomeVC.swift
//  IOS Task Trend
//
//  Created by Apple on 2/4/22.
//

import UIKit
protocol FavouriteActionDelegate {
    func addFav(fav:Favourites)
    func removeFav(fav:Favourites)
}
class HomeVC: BaseViewController<HomeViewModel> {

    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var collectionViewFlowLayout : CustomCollectionViewFlowLayout = {
        let layout = CustomCollectionViewFlowLayout(display: .list, containerWidth: self.view.bounds.width)
        return layout
    }()
    
    lazy var dataSource :ImageDataSource = {
        let d = ImageDataSource(favBehaviour: self)
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UINib(nibName: "\(ImageCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ImageCollectionViewCell.self)")
        self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
        self.collectionView.dataSource = self.dataSource
        self.collectionView.delegate = self.dataSource
        self.dataSource.zoomImageButtonDelegate = self
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
        }
        searchBar.delegate = self
        initViewModel()
    }
    override func bind(viewModel: HomeViewModel) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

        initFetch()

    }
    private func initViewModel() {
        
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.dataSource.data.value = self?.viewModel.ImageElementCellViewModels ?? []
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func initFetch() {
        viewModel.fetchPendingImage()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.reloadCollectionViewLayout(self.view.bounds.size.width)
    }
    
    private func reloadCollectionViewLayout(_ width: CGFloat) {
     
        self.collectionViewFlowLayout.containerWidth = width
        self.collectionViewFlowLayout.display = self.view.traitCollection.horizontalSizeClass == .compact && self.view.traitCollection.verticalSizeClass == .regular ?  CollectionDisplay.grid(columns: 3) : CollectionDisplay.list
     
    }
    @IBAction func layoutValueChanged(_ sender: UISegmentedControl) {

            switch sender.selectedSegmentIndex {
            case 1:
                self.collectionViewFlowLayout.display = .list
            case 2:
                self.collectionViewFlowLayout.display = .inline
            default:
                self.collectionViewFlowLayout.display = .grid(columns: 3)
            }
        }
}
extension HomeVC:FavouriteActionDelegate,ZoomImageButtonDelegate{
    func zoomImageButtonIsPressed(imageURL: String) {
      //  coordinator.mainNavigator.navigate(to:.zoomImage(imageUrl: imageURL))
    }
    
    func addFav(fav: Favourites) {
        viewModel.addFav(fav: fav)
    }
    
    func removeFav(fav: Favourites) {
        viewModel.removeFav(fav: fav)
    }
    
    
}
extension HomeVC:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else{
            return
        }
        if !text.trimmingCharacters(in: .whitespaces).isEmpty {
         coordinator.mainNavigator.navigate(to: .search(query: text))
        }
    }
}
