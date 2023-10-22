//
//  Database.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 22.10.23.
//

import Foundation
import RealmSwift

class Database {
    let realm = try! Realm()
    func getFilePath() {
        if let url = realm.configuration.fileURL {
            print(url)
        }
    }
    
}
