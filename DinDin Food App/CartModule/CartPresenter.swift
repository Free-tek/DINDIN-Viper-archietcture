//
//  CartPresenter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import Foundation

protocol CartPresentation {
    
    func viewDidLoad() -> Void

}

class CartPresenter{
    
    weak var view: CartView?
    var interactor: CartInteractions
    var router: CartRouter
    
    init(view: CartView, interactor: CartInteractions, router: CartRouter){
        self.view = view
        self.interactor = interactor
        self.router = router
        
    }
    
}


extension CartPresenter: CartPresentation{
    
    func viewDidLoad(){
        
        
        DispatchQueue.main.async {
            [weak self] in
            self!.view?.setUpElements()
            
            
        }
        
        
        interactor.fetchCartsData( completion: { (result) in
            
            DispatchQueue.main.async { [weak self] in
                self!.view?.initViewModel(cartViewModelController: result)
                self!.view?.setUpTableView()
                self!.view?.setupTotalAmountObserver()
                self!.view?.setupTableViewOrdersDataObserver()
                
            }
            
        })
        
    }
}
