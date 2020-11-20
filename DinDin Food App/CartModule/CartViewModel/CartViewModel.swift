//
//  CartViewModel.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import Foundation

struct CartViewModel {
    let orderName: String?
    let orderImage: String?
    let orderStoreId: String?
    let orderPrice: Int?

    init(OrderModel: OrderModel) {
        self.orderName = OrderModel.orderName
        self.orderImage = OrderModel.orderImage
        self.orderStoreId = OrderModel.orderStoreId
        self.orderPrice = OrderModel.orderPrice
    }

}
