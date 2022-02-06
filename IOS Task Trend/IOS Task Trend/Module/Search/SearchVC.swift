//
//  SearchVC.swift
//  IOS Task Trend
//
//  Created by Apple on 2/4/22.
//

import UIKit

class SearchVC: BaseViewController<SearchViewModel> {

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
        searchBar.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UINib(nibName: "\(ImageCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ImageCollectionViewCell.self)")
        self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
        self.collectionView.dataSource = self.dataSource
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
        }
        initViewModel()
      
    }
    override func bind(viewModel: SearchViewModel) {
        searchBar.text = viewModel.query
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false

        initFetch()

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = true

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
        self.collectionViewFlowLayout.display =  CollectionDisplay.list
     
    }
   
    
}
extension SearchVC:FavouriteActionDelegate{
    func addFav(fav: Favourites) {
        viewModel.addFav(fav: fav)
    }
    
    func removeFav(fav: Favourites) {
        viewModel.removeFav(fav: fav)
    }
    
    
}
extension SearchVC:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else{
            return
        }
        if !text.trimmingCharacters(in: .whitespaces).isEmpty {
            if text != viewModel.query {
                viewModel.query = text
                initFetch()
            }
        }
    }
}
