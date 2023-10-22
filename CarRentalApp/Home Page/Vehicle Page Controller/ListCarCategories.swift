//
//  ListCarCategories.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 22.10.23.
//

import UIKit

class ListCarCategories: UICollectionViewCell {
    

    @IBOutlet weak var carCount: UILabel!
    @IBOutlet weak var carCategory: UILabel!
    @IBOutlet weak var carCategoryImageView: UIImageView!
    @IBOutlet weak var background: UIView!
    override func awakeFromNib() {
            super.awakeFromNib()
        background.layer.cornerRadius = 15
        }
}


