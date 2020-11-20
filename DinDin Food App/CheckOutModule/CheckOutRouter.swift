//
//  CheckOutRouter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import UIKit

protocol CheckOutRouting{
    
   
}
class CheckOutRouter {
    
    var currentViewController: UIViewController
    init(viewController: UIViewController){
        self.currentViewController = viewController
        
    }
    
}
extension CheckOutRouter: CheckOutRouting{
    
}
