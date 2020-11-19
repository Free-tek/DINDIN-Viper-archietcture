//
//  DrinksModel.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
struct DrinksModel {
    let drinksName: String?
    let drinksImage: String?
    let drinksDescription: String?
    let drinksStoreId: String?
    let drinksPrice: Int?

    init(drinksName: String?, drinksImage: String?, drinksDescription: String?, drinksStoreId: String?, drinksPrice: Int?) {
        self.drinksName = drinksName
        self.drinksImage = drinksImage
        self.drinksDescription = drinksDescription
        self.drinksStoreId = drinksStoreId
        self.drinksPrice = drinksPrice
    }

}
