//
//  PizzaViewModel.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
struct PizzaViewModel {
    let pizzaName: String?
    let pizzaImage: String?
    let pizzaDescription: String?
    let pizzaStoreId: String?
    let pizzaPrice: Int?

    init(pizzaModel: PizzaModel) {
        self.pizzaName = pizzaModel.pizzaName
        self.pizzaImage = pizzaModel.pizzaImage
        self.pizzaDescription = pizzaModel.pizzaDescription
        self.pizzaStoreId = pizzaModel.pizzaStoreId
        self.pizzaPrice = pizzaModel.pizzaPrice
    }

}
