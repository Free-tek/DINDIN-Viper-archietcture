//
//  SushiInteractor.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation



protocol SushiInteractions{
    
    func fetchSushiData(completion: @escaping (_ result: SushiViewModelController ) -> Void) -> Void
    
}
    
class SushiInteractor {
    
    
    
}
extension SushiInteractor: SushiInteractions{
    
    func fetchSushiData(completion: @escaping (_ result: SushiViewModelController ) -> Void){
        
        var sushiViewModelController: SushiViewModelController = SushiViewModelController()
        sushiViewModelController.FetchSushiData( completion: { (result) in
            completion(sushiViewModelController)
        })
    }
    
    
}
