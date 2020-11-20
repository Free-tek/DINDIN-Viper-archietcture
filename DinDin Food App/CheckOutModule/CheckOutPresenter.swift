//
//  CheckOutPresenter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import Foundation

protocol CheckOutPresentation {
    
    func viewDidLoad() -> Void
    func backToMenu() -> Void
    func toFirstTabLeft() -> Void
    func toSecondTabLeft() -> Void
    func toThirdTabLeft() -> Void
    func toFirstTabRight() -> Void
    func toSecondTabRight() -> Void
    func toThirdTabRight() -> Void
    

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
    
    func backToMenu(){
        router.navigateBackToMenu()
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
