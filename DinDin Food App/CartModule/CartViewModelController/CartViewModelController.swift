//
//  CartViewModelController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import Foundation
import RxSwift
import RxCocoa

class CartViewModelController{
    
    var viewModels: BehaviorRelay<[CartViewModel?]> = BehaviorRelay(value: [])
    

    func FetchCartsData(completion: @escaping (_ success: Bool) -> ()){
        var orderModel = [OrderModel?]()
        
        orderModel =  CartOrdersModel.seeOrders.orders.value
        self.viewModels = BehaviorRelay(value: self.initViewModels(orderModel))
        completion(true)
    
    }
    
    var totalPriceOfOrders: Int{
        var total = 0
      
        
        for item in viewModels.value{
            total = total + (item?.orderPrice)!
        }
        
        return total
    }
    
    var viewModelsCount: Int {
        return viewModels.value.count
    }
    
    var allViewModels: [CartViewModel?] {
        return viewModels.value
    }

    func viewModel(at index: Int) -> CartViewModel?  {
        guard index >= 0 && index < viewModelsCount else { return nil }
        return viewModels.value[index]
    }


    func initViewModels(_ orderModel: [OrderModel?]) -> [CartViewModel?] {
        return orderModel.map { order in
            if let order = order {
                return CartViewModel(OrderModel: order)
            } else {
                return nil
            }
        }
    }
    
}


