//
//  HomeViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import UIKit

protocol HomeView {
    
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var menuContainerViewHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var scrolleViewContentViewHeightConsttraints: NSLayoutConstraint!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pagerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setUpElements()
    }
    

    func setUpElements(){
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let ScreenHeight = screenSize.height
        
        
        menuContainerViewHeightConstraints.constant = ScreenHeight
        menuContainerView.layoutIfNeeded()
        
        
        scrolleViewContentViewHeightConsttraints.constant = ScreenHeight + pagerView.bounds.height
        
        scrollViewContentView.layoutIfNeeded()
        
        
        scrollViewHeightConstraint.constant = ScreenHeight + pagerView.bounds.height
        
        scrollView.layoutIfNeeded()
        
    }
    
}

extension HomeViewController: HomeView{
    
     
}
