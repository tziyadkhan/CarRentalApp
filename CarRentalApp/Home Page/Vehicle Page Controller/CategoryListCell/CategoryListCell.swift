//
//  CategoryListCell.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 23.10.23.
//

import UIKit

class CategoryListCell: UICollectionViewCell {

    @IBOutlet weak var carCategoryCount: UILabel!
    @IBOutlet weak var carCategoryLabel: UILabel!
    @IBOutlet weak var carCategoryImage: UIImageView!
    @IBOutlet weak var background: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        background.layer.cornerRadius = 20
//        background.backgroundColor = .red
        
    }

}
