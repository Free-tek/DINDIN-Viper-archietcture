//
//  DrinksPresenter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
protocol DrinksPresentation {
    
    func viewDidLoad() -> Void

}

class DrinksPresenter{
    
    weak var view: DrinksView?
    var interactor: DrinksInteractions
    var router: DrinksRouting
    
    init(view: DrinksView, interactor: DrinksInteractions, router: DrinksRouting){
        self.view = view
        self.interactor = interactor
        self.router = router
        
    }
    
}


extension DrinksPresenter: DrinksPresentation{
    
    func viewDidLoad(){
        
        DispatchQueue.main.async {
            [weak self] in
            self!.view?.setUpElements()
        }
        
        interactor.fetchDrinksData( completion: { (result) in
            DispatchQueue.main.async { [weak self] in
                self!.view?.initViewModel(drinksViewModelController: result)
                self!.view?.setUpTableView()
                
            }
            
        })
    }
}
