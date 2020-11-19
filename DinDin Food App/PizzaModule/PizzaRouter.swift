//
//  PizzaRouter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import UIKit

protocol PizzaRouting{
    
}
class PizzaRouter {
    
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
        
    }
    
}
extension PizzaRouter: PizzaRouting{
    
    
}
