//
//  CartInteractor.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import Foundation


protocol CartInteractions{
    
    func fetchCartsData(completion: @escaping (_ result: CartViewModelController ) -> Void) -> Void
}
    
class CartInteractor {
    
    
    
}
extension CartInteractor: CartInteractions{
    
    func fetchCartsData(completion: @escaping (_ result: CartViewModelController ) -> Void){
        
        var cartViewModelController: CartViewModelController = CartViewModelController()
        cartViewModelController.FetchCartsData( completion: { (result) in
            completion(cartViewModelController)
        })
    }
    
}
