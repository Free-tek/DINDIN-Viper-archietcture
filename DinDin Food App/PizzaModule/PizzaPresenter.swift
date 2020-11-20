//
//  PizzaPresenter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation

protocol PizzaPresentation {
    
    func viewDidLoad() -> Void

}

class PizzaPresenter{
    
    weak var view: PizzaView?
    var interactor: PizzaInteractions
    var router: PizzaRouting
    
    init(view: PizzaView, interactor: PizzaInteractions, router: PizzaRouting){
        self.view = view
        self.interactor = interactor
        self.router = router
        
    }
    
}


extension PizzaPresenter: PizzaPresentation{
    
    func viewDidLoad(){
        
        DispatchQueue.main.async {
            [weak self] in
            self!.view?.setUpElements()
        }
        
        interactor.fetchPizzaData( completion: { (result) in
            DispatchQueue.main.async { [weak self] in
                self!.view?.initViewModel(pizzaViewModelController: result)
                self!.view?.setUpTableView()
                
            }
           
        })
    }
}
