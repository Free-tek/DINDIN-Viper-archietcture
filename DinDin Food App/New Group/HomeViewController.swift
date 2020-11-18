//
//  HomeViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var PagerContainerView: UIView!
    @IBOutlet weak var menuContainerViewController: UIView!
    @IBOutlet weak var menuContainerViewHeightConsttraint:
        
        NSLayoutConstraint!
    @IBOutlet weak var scrollContentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElement()
    }
    
    
    
    func setUpElement(){
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let ScreenHeight = screenSize.height
        
        
        menuContainerViewHeightConsttraint.constant = screenSize.height + 20
        menuContainerViewController.layoutIfNeeded()
        
        scrollContentViewHeightConstraint.constant = screenSize.height + PagerContainerView.bounds.height
        scrollView.layoutIfNeeded()
        
        
        menuContainerViewHeightConsttraint.constant = screenSize.height + PagerContainerView.bounds.height
        menuContainerViewController.layoutIfNeeded()
    }


}
