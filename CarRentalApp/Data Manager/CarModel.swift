//
//  CarModel.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 22.10.23.
//

import Foundation
import RealmSwift

class CarModel: Object {
    @Persisted var name: String? //Toyota
    @Persisted var model: String? // Camry
    @Persisted var engine: String? // 2.0T
    @Persisted var price: String? // 230$
    @Persisted var category: String = CarCategory.standard.rawValue // Prestige
}

enum CarCategory: String, CaseIterable {
    case standard = "Standard"
    case prestige = "Prestige"
    case suv = "SUV"
}
