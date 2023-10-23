//
//  SearchPageController.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 22.10.23.
//

import UIKit
import RealmSwift

class SearchPageController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let helper = Database()
    var carItems = [CarModel]()
    let realm = try! Realm()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        helper.getFilePath()
        fetchItems()
        configureSearchController()
        collectionView.register(UINib(nibName: "CarListCell", bundle: nil), forCellWithReuseIdentifier: "CarListCell")
    }
    


}

extension SearchPageController {
    func fetchItems() {
        carItems.removeAll()
        let data = realm.objects(CarModel.self)
        carItems.append(contentsOf: data)
        collectionView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func configureSearchController() {
        searchController.searchBar.placeholder = "Search for a car"
        searchController.searchBar.layer.masksToBounds = true
        //        searchController.searchResultsUpdater = self
        //        searchController.searchBar.delegate = self
        //        searchController.obscuresBackgroundDuringPresentation = false
        //        searchController.searchBar.enablesReturnKeyAutomatically = false
        //        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        //        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        //        definesPresentationContext = true
    }
}

extension SearchPageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarListCell", for: indexPath) as! CarListCell
        cell.carNameLabel.text = carItems[indexPath.row].name
        cell.carModelLabel.text = carItems[indexPath.row].model
        cell.carImageView.image = UIImage(named: carItems[indexPath.row].model ?? "")
        cell.carPriceLabel.text = carItems[indexPath.row].price
        cell.carEngineLabel.text = carItems[indexPath.row].engine
        return cell
    }
}
