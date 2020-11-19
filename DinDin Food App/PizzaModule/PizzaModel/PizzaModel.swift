//
//  PizzaModel.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
struct PizzaModel {
    let pizzaName: String?
    let pizzaImage: String?
    let pizzaDescription: String?
    let pizzaStoreId: String?
    let pizzaPrice: Int?

    init(pizzaName: String?, pizzaImage: String?, pizzaDescription: String?, pizzaStoreId: String?, pizzaPrice: Int?) {
        self.pizzaName = pizzaName
        self.pizzaImage = pizzaImage
        self.pizzaDescription = pizzaDescription
        self.pizzaStoreId = pizzaStoreId
        self.pizzaPrice = pizzaPrice
    }

}
