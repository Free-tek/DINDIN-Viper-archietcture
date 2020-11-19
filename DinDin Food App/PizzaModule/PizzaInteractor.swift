//
//  PizzaInteractor.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation


protocol PizzaInteractions{
    
    func fetchPizzaData(completion: @escaping (_ result: PizzaViewModelController ) -> Void) -> Void
    
}
    
class PizzaInteractor {
    
    
    
}
extension PizzaInteractor: PizzaInteractions{
    
    func fetchPizzaData(completion: @escaping (_ result: PizzaViewModelController ) -> Void){
        
        var pizzaViewModelController: PizzaViewModelController = PizzaViewModelController()
        pizzaViewModelController.FetchPizzaData( completion: { (result) in
            completion(pizzaViewModelController)
        })
    }
    
    
}
