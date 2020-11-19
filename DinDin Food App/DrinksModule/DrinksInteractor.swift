//
//  DrinksInteractor.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation


protocol DrinksInteractions{
    
    func fetchDrinksData(completion: @escaping (_ result: DrinksViewModelController ) -> Void) -> Void
    
}
    
class DrinksInteractor {
    
    
    
}
extension DrinksInteractor: DrinksInteractions{
    
    func fetchDrinksData(completion: @escaping (_ result: DrinksViewModelController ) -> Void){
        
        var drinksViewModelController: DrinksViewModelController = DrinksViewModelController()
        drinksViewModelController.FetchDrinksData( completion: { (result) in
            completion(drinksViewModelController)
        })
    }
    
    
}
