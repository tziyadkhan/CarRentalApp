//
//  CarModel.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 22.10.23.
//

import Foundation
import RealmSwift

class CarModel: Object {
    @Persisted var name: String?
    @Persisted var model: String?
    @Persisted var engine: String?
    @Persisted var price: String?
    @Persisted var category: String = CarCategory.standard.rawValue
}

enum CarCategory: String, CaseIterable {
    case standard = "Standard"
    case prestige = "Prestige"
    case suv = "SUV"
}
