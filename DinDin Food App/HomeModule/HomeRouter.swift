//
//  HomeRouter.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//
import UIKit

protocol HomeRouting{
    
}
class HomeRouter {
    
    var viewController: UIViewController
    init(viewController: UIViewController){
        self.viewController = viewController
        
    }
    
}
extension HomeRouter: HomeRouting{
    
    
}
