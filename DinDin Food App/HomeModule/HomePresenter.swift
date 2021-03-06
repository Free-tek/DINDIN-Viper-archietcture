//
//  HomePresenter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import Foundation

protocol HomePresentation {
    
    func viewDidLoad() -> Void
    func eventToCarts() -> Void
    func toFirstTabLeft() -> Void
    func toSecondTabLeft() -> Void
    func toThirdTabLeft() -> Void
    func toFirstTabRight() -> Void
    func toSecondTabRight() -> Void
    func toThirdTabRight() -> Void

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
    
    func eventToCarts(){
        router.navigateToCartsViewController()
    }
    
    func toFirstTabLeft(){
        DispatchQueue.main.async { [weak self] in
            self!.view?.navigateToFirstTabLeft()
        }
    }
    
    func toSecondTabLeft(){
        DispatchQueue.main.async { [weak self] in
            self!.view?.navigateToSecondTabLeft()
        }
    }
    
    func toThirdTabLeft(){
        
        DispatchQueue.main.async { [weak self] in
            self!.view?.navigateToThirdTabLeft()
        }
    }
    
    func toFirstTabRight(){
        DispatchQueue.main.async { [weak self] in
            self!.view?.navigateToFirstTabRight()
        }
    }
    
    func toSecondTabRight(){
        DispatchQueue.main.async { [weak self] in
            self!.view?.navigateToSecondTabRight()
        }
    }
    
    func toThirdTabRight(){
        
        DispatchQueue.main.async { [weak self] in
            self!.view?.navigateToThirdTabRight()
        }
    }
}

