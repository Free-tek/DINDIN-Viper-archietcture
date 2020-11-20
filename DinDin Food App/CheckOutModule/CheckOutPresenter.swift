//
//  CheckOutPresenter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import Foundation

protocol CheckOutPresentation {
    
    func viewDidLoad() -> Void
    

}

class CheckOutPresenter{
    
    weak var view: CheckOutView?
    var interactor: CheckOutInteractions
    var router: CheckOutRouter
    
    init(view: CheckOutView, interactor: CheckOutInteractions, router: CheckOutRouter){
        self.view = view
        self.interactor = interactor
        self.router = router
        
    }
    
}

extension CheckOutPresenter: CheckOutPresentation{
    
    func viewDidLoad(){
        
        DispatchQueue.main.async {
            [weak self] in
            self!.view?.setUpElements()
        
        }
        
    }
    
    
}
