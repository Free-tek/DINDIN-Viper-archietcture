//
//  SushiPresenter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
protocol SushiPresentation {
    
    func viewDidLoad() -> Void

}

class SushiPresenter{
    
    weak var view: SushiView?
    var interactor: SushiInteractions
    var router: SushiRouting
    
    init(view: SushiView, interactor: SushiInteractions, router: SushiRouting){
        self.view = view
        self.interactor = interactor
        self.router = router
        
    }
    
}


extension SushiPresenter: SushiPresentation{
    
    func viewDidLoad(){
        
        DispatchQueue.main.async {
            [weak self] in
            self!.view?.setUpElements()
        }
        
        interactor.fetchSushiData( completion: { (result) in
            DispatchQueue.main.async { [weak self] in
                self!.view?.initViewModel(sushiViewModelController: result)
                self!.view?.setUpTableView()
                
            }
            
        })
    }
}
