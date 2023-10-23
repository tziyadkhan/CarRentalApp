//
//  VehiclePageController.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 22.10.23.
//

import UIKit
import RealmSwift

class VehiclePageController: UIViewController {
    


    @IBOutlet weak var collectionView: UICollectionView!
    let category = ["Standard", "Prestige", "SUV"]
    let helper = Database()
    var carItems = [CarModel]()
    let realm = try! Realm()
    let searchController = UISearchController(searchResultsController: nil)
    var categoryCounts = [String: Int]()
    //    var searchedCar = [CarModel]()
    //    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Car Rental"
        helper.getFilePath()
        fetchItems()
        configureSearchController()
//        collectionView.register(UINib(nibName: "CarListCell", bundle: nil), forCellWithReuseIdentifier: "CarListCell")
        for category in CarCategory.allCases {
            let categoryCars = realm.objects(CarModel.self).filter("category = %@", category.rawValue)
            categoryCounts[category.rawValue] = categoryCars.count
        }
    }
    
    
}

extension VehiclePageController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCarCategories", for: indexPath) as! ListCarCategories
        cell.carCategoryImageView.image = UIImage(named: category[indexPath.item])
        let category = CarCategory.allCases[indexPath.item]
        cell.carCategory.text = category.rawValue
        if let count = categoryCounts[category.rawValue] {
            cell.carCount.text = "\(count)"
        } else {
            cell.carCount.text = "0"
        }
        
//        if (collectionView == collectionView2) {
//            let cell2 = collectionView2.dequeueReusableCell(withReuseIdentifier: "ListCarsCell", for: indexPath) as! ListCarsCell
//            cell2.background.backgroundColor = UIColor.blue
//            return cell2
//        }
        return cell


    }
    
    
}

extension VehiclePageController {
    func fetchItems() {
        carItems.removeAll()
        let data = realm.objects(CarModel.self)
        carItems.append(contentsOf: data)
        collectionView.reloadData()
    }
}












extension VehiclePageController: UISearchResultsUpdating {
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
//
//    func updateSearchResults(for searchController: UISearchController) {
//
//        let searchText = searchController.searchBar.text
//        if (searchText != nil) {
//            searching = true
//            searchedCar.removeAll()
//
//            for car in carItems {
//                if ((car.name?.lowercased().contains(searchText?.lowercased() ?? "")) != nil) {
//                    searchedCar.append(car)
//                }
//            }
//        } else {
//            searching = false
//            searchedCar.removeAll()
//            searchedCar = carItems
//        }
//
//        collectionView.reloadData()
//    }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        searchedCar.removeAll()
//        collectionView.reloadData()
//    }
//
//}
