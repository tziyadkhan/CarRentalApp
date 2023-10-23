//
//  CarListCell.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 23.10.23.
//

import UIKit

class CarListCell: UICollectionViewCell {

    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var carEngineLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 20
    }

}
