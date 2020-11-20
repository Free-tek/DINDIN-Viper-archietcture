//
//  HomeRouter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//
import UIKit

protocol HomeRouting{
    
    func navigateToCartsViewController() -> Void
}
class HomeRouter {
    
    var currentViewController: UIViewController
    init(viewController: UIViewController){
        self.currentViewController = viewController
        
    }
    
}
extension HomeRouter: HomeRouting{
    
    func navigateToCartsViewController(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CheckOutViewController") as! CheckOutViewController
        viewController.view.window?.rootViewController = viewController
        viewController.view.window?.makeKeyAndVisible()

        self.currentViewController.present(viewController, animated: false, completion: nil)
        
    }
    
}
