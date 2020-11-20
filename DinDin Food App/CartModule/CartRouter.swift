//
//  CartRouter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import UIKit

protocol CartRouting{
    
}
class CartRouter {
    
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
        
    }
    
}
extension CartRouter: CartRouting{
    
    
    
    
}

