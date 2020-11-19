//
//  HomeModuleBuilder.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import Foundation
import UIKit

class HomeModuleBuilder{
    
    static func build() -> UIViewController{
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier:  "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor()
        let router = HomeRouter(viewController: homeViewController)
        let homePresenter = HomePresenter(view: homeViewController, interactor: interactor, router: router)
        homeViewController.presenter = homePresenter  
        return homeViewController
        
    }
}
