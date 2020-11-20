//
//  CheckOutRouter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import UIKit

protocol CheckOutRouting{
    
   func navigateBackToMenu() -> Void
    
}
class CheckOutRouter {
    
    var currentViewController: UIViewController
    init(viewController: UIViewController){
        self.currentViewController = viewController
        
    }
    
}
extension CheckOutRouter: CheckOutRouting{
 
    func navigateBackToMenu(){
        currentViewController.dismiss(animated: false, completion: nil)
    }
    
    
}
