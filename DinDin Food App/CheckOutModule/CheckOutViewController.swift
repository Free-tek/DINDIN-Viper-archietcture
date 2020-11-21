//
//  CheckOutViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/20/20.
//

import UIKit

protocol CheckOutView: class {
    func setUpElements() -> (Void)
    func navigateToFirstTabLeft() -> (Void)
    func navigateToSecondTabLeft() -> (Void)
    func navigateToThirdTabLeft() -> (Void)
    func navigateToFirstTabRight() -> (Void)
    func navigateToSecondTabRight() -> (Void)
    func navigateToThirdTabRight() -> (Void)
    
}

class CheckOutViewController: UIViewController {

    @IBOutlet weak var cartContainerViewController: UIView!
    @IBOutlet weak var ordersContainerViewConntroller: UIView!
    @IBOutlet weak var informationContainerViewController: UIView!
    
    @IBOutlet weak var tab1Header: UILabel!
    @IBOutlet weak var tab2Header: UILabel!
    @IBOutlet weak var tab3Header: UILabel!
    
    @IBOutlet weak var backToMenuButton: UIButton!
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
    
    @IBAction func backToMenuFunction(_ sender: Any) {
        self.presenter.backToMenu()
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
                
                presenter.toFirstTabLeft()
                
                
            }else if currentPageIndex == 1{
                currentPageIndex = currentPageIndex + 1
                
                presenter.toThirdTabLeft()
                
            
            }else if currentPageIndex == 0{
                currentPageIndex = currentPageIndex + 1
                
                presenter.toSecondTabLeft()
                
                
            }
           
        }
        
        if sender.direction == .right {
            
            if currentPageIndex == 0{
                currentPageIndex = 2
                presenter.toThirdTabRight()
                
            }else if currentPageIndex == 1{
                currentPageIndex = currentPageIndex - 1
                presenter.toFirstTabRight()
                
            }else if currentPageIndex == 2{
                currentPageIndex = currentPageIndex - 1
                presenter.toSecondTabRight()
                
            }
          
            
        }
    }
    
    
    func navigateToFirstTabLeft(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            
            self!.tab1Header.text = CheckOutPageTabs.cart.rawValue
            self!.tab2Header.text = CheckOutPageTabs.orders.rawValue
            self!.tab3Header.text = CheckOutPageTabs.information.rawValue
            
        })
        
        swapContainerViewsLeftSlide(slideOutView: informationContainerViewController, slideInView: cartContainerViewController)
        
        ordersContainerViewConntroller.alpha = 0
        
    }
    
    
    func navigateToSecondTabLeft(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
        
            self!.tab1Header.text = CheckOutPageTabs.orders.rawValue
            self!.tab2Header.text = CheckOutPageTabs.information.rawValue
            self!.tab3Header.text = CheckOutPageTabs.cart.rawValue
        
        })
        
        
        
        swapContainerViewsLeftSlide(slideOutView: cartContainerViewController, slideInView: ordersContainerViewConntroller)
        
        informationContainerViewController.alpha = 0
        
    }
    
    func navigateToThirdTabLeft(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            
            self!.tab1Header.text = CheckOutPageTabs.information.rawValue
            self!.tab2Header.text = CheckOutPageTabs.cart.rawValue
            self!.tab3Header.text = CheckOutPageTabs.orders.rawValue
            
        })
        
        
        
        
        swapContainerViewsLeftSlide(slideOutView: ordersContainerViewConntroller, slideInView: informationContainerViewController)
        
        cartContainerViewController.alpha = 0
       
        
    }
    
    func navigateToFirstTabRight(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            
            self!.tab1Header.text = CheckOutPageTabs.cart.rawValue
            self!.tab2Header.text = CheckOutPageTabs.orders.rawValue
            self!.tab3Header.text = CheckOutPageTabs.information.rawValue
            
        })
        
        
        swapContainerViewsRightSlide(slideOutView: informationContainerViewController, slideInView: cartContainerViewController)
        
        ordersContainerViewConntroller.alpha = 0
       
    }
    
    func navigateToSecondTabRight(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            
            self!.tab1Header.text = CheckOutPageTabs.information.rawValue
            self!.tab2Header.text = CheckOutPageTabs.cart.rawValue
            self!.tab3Header.text = CheckOutPageTabs.orders.rawValue
            
        })
       
        
        
        swapContainerViewsRightSlide(slideOutView: ordersContainerViewConntroller, slideInView: informationContainerViewController)
        
        cartContainerViewController.alpha = 0
        
        
        
        
    }
    
    func navigateToThirdTabRight(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self!.tab1Header.text = CheckOutPageTabs.orders.rawValue
            self!.tab2Header.text = CheckOutPageTabs.information.rawValue
            self!.tab3Header.text = CheckOutPageTabs.cart.rawValue
            
        })
        
        
        
        swapContainerViewsRightSlide(slideOutView: cartContainerViewController, slideInView: ordersContainerViewConntroller)
        
        informationContainerViewController.alpha = 0
        
    }
    
    
    func swapContainerViewsLeftSlide(slideOutView: UIView, slideInView: UIView){
        
        slideOutView.alpha = 1
        slideInView.alpha = 1
        slideInView.center.x += self.view.bounds.width
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.25, options: .beginFromCurrentState, animations: {
            slideOutView.center.x -= self.view.bounds.width
            slideInView.center.x -= self.view.bounds.width

        }, completion: { (finished: Bool) -> Void in
            slideOutView.alpha = 0
            slideInView.alpha = 1
            slideOutView.center.x += self.view.bounds.width

        })
    
    }
    
    
    func swapContainerViewsRightSlide(slideOutView: UIView, slideInView: UIView){
        
        slideOutView.alpha = 1
        slideInView.alpha = 1
        slideInView.center.x -= self.view.bounds.width
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.1, options: .beginFromCurrentState, animations: {
            slideOutView.center.x += self.view.bounds.width
            slideInView.center.x += self.view.bounds.width

        }, completion: { (finished: Bool) -> Void in
            slideOutView.alpha = 0
            slideInView.alpha = 1
            slideOutView.center.x -= self.view.bounds.width

        })
    
    }
    
   
}
