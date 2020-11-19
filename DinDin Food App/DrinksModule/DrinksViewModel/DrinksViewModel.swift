//
//  DrinksViewModel.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
struct DrinksViewModel {
    let drinksName: String?
    let drinksImage: String?
    let drinksDescription: String?
    let drinksStoreId: String?
    let drinksPrice: Int?

    init(drinksModel: DrinksModel) {
        self.drinksName = drinksModel.drinksName
        self.drinksImage = drinksModel.drinksImage
        self.drinksDescription = drinksModel.drinksDescription
        self.drinksStoreId = drinksModel.drinksStoreId
        self.drinksPrice = drinksModel.drinksPrice
    }

}
