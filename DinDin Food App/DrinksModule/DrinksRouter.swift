//
//  DrinksRouter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import UIKit

protocol DrinksRouting{
    
}
class DrinksRouter {
    
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
        
    }
    
}
extension DrinksRouter: DrinksRouting{
    
    
}
