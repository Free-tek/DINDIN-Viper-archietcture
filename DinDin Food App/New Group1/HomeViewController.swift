//
//  HomeViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import UIKit
import AACarousel
import Kingfisher
import RxSwift
import RxCocoa

protocol HomeView: class {
    
    func setUpElements() -> (Void)
    func setUpPromoOffersView(promoBannerImages: [String]) -> (Void)
    func setupTotalOrdersObserver() -> (Void)
    func navigateToFirstTabLeft() -> (Void)
    func navigateToSecondTabLeft() -> (Void)
    func navigateToThirdTabLeft() -> (Void)
    func navigateToFirstTabRight() -> (Void)
    func navigateToSecondTabRight() -> (Void)
    func navigateToThirdTabRight() -> (Void)
}

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var menuViewBoundaryView: UIView!
    @IBOutlet weak var menuViewBoundaryViewConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var tabHeader1: UILabel!
    @IBOutlet weak var tabHeader2: UILabel!
    @IBOutlet weak var tabHeader3: UILabel!
    
    
    @IBOutlet weak var pizzaContainerViewTab: UIView!
    @IBOutlet weak var pizzaContainerViewTabHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var sushiContainerViewTab: UIView!
    @IBOutlet weak var sushiContainerViewTabHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var DrinksContainerViewTab: UIView!
    @IBOutlet weak var DrinksContainerViewTabHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var scrolleViewContentViewHeightConsttraints: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pagerView: AACarousel!
    
    
    @IBOutlet weak var cartsButtton: UIButton!
    @IBOutlet weak var orderCount: UILabel!
    
    var presenter: HomePresentation!
    var pizzaContainerViewController: PizzaContainerViewController!
    
    var disposeBag = DisposeBag()
    
    enum HomePageTabs: String {
       case pizza = "Pizza"
       case sushi = "Sushi"
       case drinks = "Drinks"
    }
    var currentPage = HomePageTabs.pizza
    var currentPageIndex = 0
    
    
    enum Segues{
        static let toPromoOffers = "toPizzaContainerView"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.viewDidLoad()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == Segues.toPromoOffers{
            pizzaContainerViewController = segue.destination as! PizzaContainerViewController
        }
        
    }
    

    @IBAction func toCartsPage(_ sender: Any) {
        presenter.eventToCarts()
    }
    
    
}

extension HomeViewController: HomeView{
    
    
    func setUpElements(){
        
        orderCount.alpha = 0
        cartsButtton.alpha = 0
        
        orderCount.backgroundColor = UIColor.green
        orderCount.layer.cornerRadius = orderCount.frame.width/2
        orderCount.layer.masksToBounds = true
        
        cartsButtton.layer.cornerRadius = cartsButtton.frame.width/2
        cartsButtton.layer.shadowOpacity = 0.3
        cartsButtton.layer.shadowRadius = 4
        cartsButtton.layer.shadowOffset = CGSize(width: 0, height: 0)
        cartsButtton.layer.shadowColor = UIColor.black.cgColor
        
        

        
        pagerView.layer.contents = #imageLiteral(resourceName: "default1").cgImage
        
        tabHeader1.textColor = UIColor.black
        tabHeader2.textColor = UIColor.gray
        tabHeader3.textColor = UIColor.gray
        
        let screenSize = UIScreen.main.bounds
        let ScreenHeight = screenSize.height
        
        menuViewBoundaryViewConstraint.constant = ScreenHeight
        menuViewBoundaryView.layoutIfNeeded()
        
        menuViewBoundaryView.roundCorners([.topRight, .topLeft, .topRight, .topLeft], radius: 35)
        
        
        pizzaContainerViewTabHeightConstraint.constant = ScreenHeight
        pizzaContainerViewTab.layoutIfNeeded()
        
        sushiContainerViewTabHeightConstraint.constant = ScreenHeight
        sushiContainerViewTab.layoutIfNeeded()
        
        DrinksContainerViewTabHeightConstraint.constant = ScreenHeight
        DrinksContainerViewTab.layoutIfNeeded()
        
        
        scrolleViewContentViewHeightConsttraints.constant = ScreenHeight + pagerView.bounds.height
        scrollViewContentView.layoutIfNeeded()
        
        
        scrollViewHeightConstraint.constant = ScreenHeight + pagerView.bounds.height
        scrollView.layoutIfNeeded()
        
        
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(swipeMade(_:)))
           leftRecognizer.direction = .left
        
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(swipeMade(_:)))
           rightRecognizer.direction = .right
           self.view.addGestureRecognizer(leftRecognizer)
           self.view.addGestureRecognizer(rightRecognizer)
        
    
        
    }
    
    func setupTotalOrdersObserver() {
        CartOrdersModel.seeOrders.orders.asObservable()
        .subscribe(onNext: {
          [unowned self] orders in
            
            self.pulseAnimation(item: orderCount)
            
            if orders.count > 50{
                orderCount.text = "50+"
            }else if orders.count > 0{
                orderCount.alpha = 1
                cartsButtton.alpha = 1
                orderCount.text = "\(orders.count)"
            }else if orders.count == 0 {
                orderCount.alpha = 0
                cartsButtton.alpha = 0
            }
        
        })
        .disposed(by: disposeBag)
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
    
    func setUpPromoOffersView(promoBannerImages: [String]){
        
        let pathArray = promoBannerImages
                
        pagerView.delegate = self
        pagerView.setCarouselData(paths: pathArray,  describedTitle: [], isAutoScroll: true, timer: 3.0, defaultImage: "default.png")
        pagerView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        pagerView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: UIColor.clear)
        
    }
    
    func pulseAnimation(item: UILabel){
        
        
    
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 1.0
        pulse.toValue = 1.12
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 0.8

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1
        animationGroup.animations = [pulse]

        item.layer.add(animationGroup, forKey: "pulse")
            
            
    }
    
    
    func navigateToFirstTabLeft(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self!.tabHeader1.text = HomePageTabs.pizza.rawValue
            self!.tabHeader2.text = HomePageTabs.sushi.rawValue
            self!.tabHeader3.text = HomePageTabs.drinks.rawValue
        })
        
        swapContainerViewsLeftSlide(slideOutView: DrinksContainerViewTab, slideInView: pizzaContainerViewTab)
        sushiContainerViewTab.alpha = 0
        
    }
    
    
    func navigateToSecondTabLeft(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self!.tabHeader1.text = HomePageTabs.sushi.rawValue
            self!.tabHeader2.text = HomePageTabs.drinks.rawValue
            self!.tabHeader3.text = HomePageTabs.pizza.rawValue
        })
        
        
        swapContainerViewsLeftSlide(slideOutView: pizzaContainerViewTab, slideInView: sushiContainerViewTab)
        DrinksContainerViewTab.alpha = 0
    }
    
    func navigateToThirdTabLeft(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self!.tabHeader1.text = HomePageTabs.drinks.rawValue
            self!.tabHeader2.text = HomePageTabs.pizza.rawValue
            self!.tabHeader3.text = HomePageTabs.sushi.rawValue
        })
        
        
        swapContainerViewsLeftSlide(slideOutView: sushiContainerViewTab, slideInView: DrinksContainerViewTab)
        pizzaContainerViewTab.alpha = 0
        
        
    }
    
    func navigateToFirstTabRight(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self!.tabHeader1.text = HomePageTabs.pizza.rawValue
            self!.tabHeader2.text = HomePageTabs.sushi.rawValue
            self!.tabHeader3.text = HomePageTabs.drinks.rawValue
        })
        
        
        
        swapContainerViewsRightSlide(slideOutView: sushiContainerViewTab, slideInView: pizzaContainerViewTab)
        DrinksContainerViewTab.alpha = 0
    }
    
    func navigateToSecondTabRight(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self!.tabHeader1.text = HomePageTabs.sushi.rawValue
            self!.tabHeader2.text = HomePageTabs.drinks.rawValue
            self!.tabHeader3.text = HomePageTabs.pizza.rawValue
        })
        
        
        
        swapContainerViewsRightSlide(slideOutView: DrinksContainerViewTab, slideInView: sushiContainerViewTab)
        pizzaContainerViewTab.alpha = 0
        
        
    }
    
    func navigateToThirdTabRight(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self!.tabHeader1.text = HomePageTabs.drinks.rawValue
            self!.tabHeader2.text = HomePageTabs.pizza.rawValue
            self!.tabHeader3.text = HomePageTabs.sushi.rawValue
        })
        
    
        swapContainerViewsRightSlide(slideOutView: pizzaContainerViewTab, slideInView: DrinksContainerViewTab)
        sushiContainerViewTab.alpha = 0
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

extension HomeViewController: AACarouselDelegate{
    
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        
    }
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
    }
    
    func downloadImages(_ url: String, _ index: Int) {
        
        let imageView = UIImageView()
        imageView.setImage(with: url)
        
        guard let urlLink = URL.init(string: url) else {
            return
        }
        let resource = ImageResource(downloadURL: urlLink, cacheKey: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            self.pagerView.images[index] = image!
        })
        
    }
}

extension UIImageView {
    func setImage(with urlString: String) {
        if urlString == ""{
            self.image = #imageLiteral(resourceName: "song_placeholder")
        }else{
            guard let url = URL.init(string: urlString) else {
                return
            }
            let resource = ImageResource(downloadURL: url, cacheKey: urlString)
            var kf = self.kf
            kf.indicatorType = .activity
            self.kf.setImage(with: resource)
        }
        
    }
}

extension UIView{
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)) {
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)) {
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)) {
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)) {
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask

        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
}

extension UIImageView{
    
    func roundCornersImage(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)) {
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)) {
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)) {
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)) {
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask

        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
}
