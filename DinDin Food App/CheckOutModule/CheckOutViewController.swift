//
//  CheckOutViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import UIKit

protocol CheckOutView: class {
    func setUpElements() -> (Void)
    
}

class CheckOutViewController: UIViewController {

    @IBOutlet weak var cartContainerViewController: UIView!
    @IBOutlet weak var ordersContainerViewConntroller: UIView!
    @IBOutlet weak var informationContainerViewController: UIView!
    
    @IBOutlet weak var tab1Header: UILabel!
    @IBOutlet weak var tab2Header: UILabel!
    @IBOutlet weak var tab3Header: UILabel!
    
    @IBOutlet weak var payForOrder: UIButton!
    
    var presenter: CheckOutPresentation!
    
    enum CheckOutPageTabs: String {
       case cart = "Cart"
       case orders = "Orders"
       case information = "Information"
    }
    var currentPage = CheckOutPageTabs.cart
    var currentPageIndex = 0
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let interactor = CheckOutInteractor()
        let router = CheckOutRouter(viewController: self)
        let checkOutPresenter = CheckOutPresenter(view: self, interactor: interactor, router: router)
        presenter = checkOutPresenter
        
        self.presenter.viewDidLoad()
    }
    

}


extension CheckOutViewController: CheckOutView{
    
    func setUpElements(){
        
        tab1Header.textColor = UIColor.black
        tab2Header.textColor = UIColor.gray
        tab3Header.textColor = UIColor.gray
        
        
        payForOrder.layer.cornerRadius = payForOrder.frame.width/2
        payForOrder.layer.shadowOpacity = 0.3
        payForOrder.layer.shadowRadius = 4
        payForOrder.layer.shadowOffset = CGSize(width: 0, height: 0)
        payForOrder.layer.shadowColor = UIColor.black.cgColor
        
        
        var leftRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(swipeMade(_:)))
           leftRecognizer.direction = .left
        
        var rightRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(swipeMade(_:)))
           rightRecognizer.direction = .right
           self.view.addGestureRecognizer(leftRecognizer)
           self.view.addGestureRecognizer(rightRecognizer)
    }
    
    
    @objc func swipeMade(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            
            if currentPageIndex == 2{
                currentPageIndex = 0
               
                tab1Header.text = CheckOutPageTabs.cart.rawValue
                tab2Header.text = CheckOutPageTabs.orders.rawValue
                tab3Header.text = CheckOutPageTabs.information.rawValue
                
                
                informationContainerViewController.alpha = 0
                cartContainerViewController.alpha = 1
                
            }else if currentPageIndex == 1{
                currentPageIndex = currentPageIndex + 1
                
                
                tab1Header.text = CheckOutPageTabs.information.rawValue
                tab2Header.text = CheckOutPageTabs.cart.rawValue
                tab3Header.text = CheckOutPageTabs.orders.rawValue
                
                
                ordersContainerViewConntroller.alpha = 0
                informationContainerViewController.alpha = 1
            
            }else if currentPageIndex == 0{
                currentPageIndex = currentPageIndex + 1
                
                tab1Header.text = CheckOutPageTabs.orders.rawValue
                tab2Header.text = CheckOutPageTabs.information.rawValue
                tab3Header.text = CheckOutPageTabs.cart.rawValue
                
                
                cartContainerViewController.alpha = 0
                ordersContainerViewConntroller.alpha = 1
                
            }
           
        }
        
        if sender.direction == .right {
            
            if currentPageIndex == 0{
                currentPageIndex = 2
                
                tab1Header.text = CheckOutPageTabs.information.rawValue
                tab2Header.text = CheckOutPageTabs.cart.rawValue
                tab3Header.text = CheckOutPageTabs.orders.rawValue
                
                
                ordersContainerViewConntroller.alpha = 0
                informationContainerViewController.alpha = 1
                
            }else if currentPageIndex == 1{
                currentPageIndex = currentPageIndex - 1
                
                tab1Header.text = CheckOutPageTabs.cart.rawValue
                tab2Header.text = CheckOutPageTabs.orders.rawValue
                tab3Header.text = CheckOutPageTabs.information.rawValue
                
                informationContainerViewController.alpha = 0
                cartContainerViewController.alpha = 1
                
            }else if currentPageIndex == 2{
                currentPageIndex = currentPageIndex - 1
                
                tab1Header.text = CheckOutPageTabs.orders.rawValue
                tab2Header.text = CheckOutPageTabs.information.rawValue
                tab3Header.text = CheckOutPageTabs.cart.rawValue
                
                
                cartContainerViewController.alpha = 0
                ordersContainerViewConntroller.alpha = 1
                
                
                
            }
          
            
        }
    }
    
}
