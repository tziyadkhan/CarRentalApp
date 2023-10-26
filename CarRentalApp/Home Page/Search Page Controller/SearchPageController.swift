//
//  SearchPageController.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 22.10.23.
//

import UIKit
import RealmSwift

class SearchPageController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    let helper = Database()
    var carItems = [CarModel]()
    let realm = try! Realm()
    var searching = false
    var searchedCar = [CarModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.getFilePath()
        fetchItems()
        collectionView.register(UINib(nibName: "CarListCell", bundle: nil), forCellWithReuseIdentifier: "CarListCell")
        setupSearch()
    }
    
    
    @IBAction func searchTextField(_ sender: UITextField) {
        if let searchText = sender.text, !searchText.isEmpty {
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
            cell.carImageView.image = UIImage(named: searchedCar[indexPath.row].model ?? "emptyCar")
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

// Functions
extension SearchPageController {
    // Realm Fetching the data
    func fetchItems() {
        carItems.removeAll()
        let data = realm.objects(CarModel.self)
        carItems.append(contentsOf: data)
        collectionView.reloadData()
    }
    
    func setupSearch() {
        searchTextField.layer.cornerRadius = 32
        searchTextField.layer.masksToBounds = true
        searchTextField.tintColor = UIColor.black
    }
    
}
