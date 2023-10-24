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
    @IBOutlet weak var carCollectionView: UICollectionView!
    
    let category = ["Standard", "Prestige", "SUV"]
    let helper = Database()
    var carItems = [CarModel]()
    let realm = try! Realm()
    let searchController = UISearchController(searchResultsController: nil)
    var searching = false
    var searchedCar = [CarModel]()
    var categoryCounts = [String: Int]()
    var categorySelectedIndexPath: IndexPath?
    var originalCarItems = [CarModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Car Rental"
        helper.getFilePath()
        fetchItems()
        configureSearchController()
        originalCarItems = carItems
        XibRegistration()
        categoryCount()
    }
    
}

extension VehiclePageController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searching {
                return searchedCar.count
            } else {
                if collectionView == self.collectionView {
                    return category.count
                } else if collectionView == carCollectionView {
                    return carItems.count
                }
                return 0
            }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carCollectionView {
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

        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListCell", for: indexPath) as! CategoryListCell
            cell.carCategoryImage.image = UIImage(named: category[indexPath.item])
            let category = CarCategory.allCases[indexPath.item]
            cell.carCategoryLabel.text = category.rawValue
            if let count = categoryCounts[category.rawValue] {
                cell.carCategoryCount.text = "\(count)"
            } else {
                cell.carCategoryCount.text = "0"
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = CarCategory.allCases[indexPath.item]
        let filteredCars = originalCarItems.filter{ $0.category == category.rawValue }
        
        if let previousIndexPath = categorySelectedIndexPath {         // Deselect the previously selected cell and reset its background color
            collectionView.deselectItem(at: previousIndexPath, animated: true)
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? CategoryListCell {
                previousCell.background.backgroundColor = .white // Change to the default background color
            }
        }
        categorySelectedIndexPath = indexPath // Update the selected index path
        
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? CategoryListCell {
            selectedCell.background.backgroundColor = .blue         // Change the background color of the newly selected cell
        }
        
        carItems = filteredCars
        carCollectionView.reloadData()
        //        print("Selected category: \(category)")
    }
    
}

// Functions
extension VehiclePageController {
    //    REALM fetching the data
    func fetchItems() {
        carItems.removeAll()
        let data = realm.objects(CarModel.self)
        carItems.append(contentsOf: data)
        collectionView.reloadData()
    }
    // XIB Registration
    func XibRegistration() {
        collectionView.register(UINib(nibName: "CategoryListCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListCell")
        carCollectionView.register(UINib(nibName: "CarListCell", bundle: nil), forCellWithReuseIdentifier: "CarListCell")
    }
    // Category Counting
    func categoryCount() {
        for category in CarCategory.allCases {
            let categoryCars = realm.objects(CarModel.self).filter("category = %@", category.rawValue)
            categoryCounts[category.rawValue] = categoryCars.count
        }
    }
}

// SearchBar Configuration
extension VehiclePageController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            searchedCar = carItems.filter { car in
                if let model = car.model {
                    return model.lowercased().contains(searchText.lowercased())
                }
                return false
            }
            searching = true
        } else {
            searchedCar.removeAll()
            searching = false
        }
        carCollectionView.reloadData()
    }
    
    func configureSearchController() {
        searchController.searchBar.placeholder = "Search for a car"
        searchController.searchBar.layer.masksToBounds = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

