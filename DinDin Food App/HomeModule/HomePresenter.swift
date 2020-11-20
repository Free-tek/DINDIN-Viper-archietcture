//
//  HomePresenter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import Foundation

protocol HomePresentation {
    
    func viewDidLoad() -> Void

} 

class HomePresenter{
    
    weak var view: HomeView?
    var interactor: HomeInteractions
    var router: HomeRouting
    
    init(view: HomeView, interactor: HomeInteractions, router: HomeRouting){
        self.view = view
        self.interactor = interactor
        self.router = router
        
    }
    
}

extension HomePresenter: HomePresentation{
    
    func viewDidLoad(){
        
        DispatchQueue.main.async {
            [weak self] in
            self!.view?.setUpElements()
            self!.view?.setupTotalOrdersObserver()
            
        }
        

        interactor.getPromoOffersPagerData( completion: { (result) in
            DispatchQueue.main.async { [weak self] in
                self!.view?.setUpPromoOffersView(promoBannerImages: result)
            }
            
            
        })


        
        
        
    }
}
