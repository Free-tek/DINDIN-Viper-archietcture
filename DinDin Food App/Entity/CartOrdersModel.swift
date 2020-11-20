//
//  CartOrdersModel.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import Foundation
import RxSwift
import RxCocoa

class CartOrdersModel {
  static let seeOrders = CartOrdersModel()
  let orders: BehaviorRelay<[OrderModel]> = BehaviorRelay(value: [])
}


struct OrderModel {
    let orderName: String?
    let orderImage: String?
    let orderStoreId: String?
    let orderPrice: Int?

    init(orderName: String?, orderImage: String?, orderStoreId: String?, orderPrice: Int?) {
        self.orderName = orderName
        self.orderImage = orderImage
        self.orderStoreId = orderStoreId
        self.orderPrice = orderPrice
    }

}
