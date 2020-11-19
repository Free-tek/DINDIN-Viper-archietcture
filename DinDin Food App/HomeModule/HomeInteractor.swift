//
//  HomeInteractor.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import Foundation


protocol HomeInteractions{
    
    func getPromoOffersPagerData(completion: @escaping (_ result: [String] ) -> Void) -> Void

}
    
class HomeInteractor {
    
    
    
}
extension HomeInteractor: HomeInteractions{
    
    func getPromoOffersPagerData(completion: @escaping (_ result: [String] ) -> Void){
        
        var promoPackagesService: PromoPackagesService = PromoPackagesService()
        promoPackagesService.fetchPromoPackagesBanner( completion: { (result) in
            completion(result)
        })
        
    }
    
}
