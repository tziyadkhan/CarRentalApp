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
    var searching = false
    var searchedCar = [CarModel]()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Search"
        helper.getFilePath()
        fetchItems()
        configureSearchBar()
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
}

extension SearchPageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return searchedCar.count
        } else {
            return carItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarListCell", for: indexPath) as! CarListCell
        
        if searching {
            cell.carNameLabel.text = searchedCar[indexPath.row].name
            cell.carModelLabel.text = searchedCar[indexPath.row].model
            cell.carImageView.image = UIImage(named: searchedCar[indexPath.row].model ?? "")
            cell.carPriceLabel.text = searchedCar[indexPath.row].price
            cell.carEngineLabel.text = searchedCar[indexPath.row].engine

        } else {
            cell.carNameLabel.text = carItems[indexPath.row].name
            cell.carModelLabel.text = carItems[indexPath.row].model
            cell.carImageView.image = UIImage(named: carItems[indexPath.row].model ?? "")
            cell.carPriceLabel.text = carItems[indexPath.row].price
            cell.carEngineLabel.text = carItems[indexPath.row].engine
        }
        return cell

    }

}

// SearchBar
extension SearchPageController{
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Enter the car name"
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
    }
}


extension SearchPageController: UISearchResultsUpdating, UISearchBarDelegate {
        func updateSearchResults(for searchController: UISearchController) {
            if let searchText = searchController.searchBar.text, !searchText.isEmpty {
                searching = true
                searchedCar = carItems.filter { car in
                    if let model = car.model {
                        return model.lowercased().contains(searchText.lowercased())
                    }
                    return false
                }
            } else {
                searching = false
                searchedCar.removeAll()
            }
            
            collectionView.reloadData()
        }
}
