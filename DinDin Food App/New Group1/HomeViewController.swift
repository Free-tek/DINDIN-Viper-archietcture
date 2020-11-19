//
//  HomeViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import UIKit
import AACarousel
import Kingfisher

protocol HomeView: class {
    
    func setUpElements() -> (Void)
    
    func setUpPromoOffersView(promoBannerImages: [String]) -> (Void)
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
    
    
    var presenter: HomePresentation!
    var pizzaContainerViewController: PizzaContainerViewController!
    
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
    

    
    
}

extension HomeViewController: HomeView{
    
    
    func setUpElements(){
        
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
               
                tabHeader1.text = HomePageTabs.pizza.rawValue
                tabHeader2.text = HomePageTabs.sushi.rawValue
                tabHeader3.text = HomePageTabs.drinks.rawValue
                
                
                pizzaContainerViewTab.alpha = 1
                DrinksContainerViewTab.alpha = 0
                
            }else if currentPageIndex == 1{
                currentPageIndex = currentPageIndex + 1
                
                
                tabHeader1.text = HomePageTabs.drinks.rawValue
                tabHeader2.text = HomePageTabs.pizza.rawValue
                tabHeader3.text = HomePageTabs.sushi.rawValue
                
                
                sushiContainerViewTab.alpha = 0
                DrinksContainerViewTab.alpha = 1
            
            }else if currentPageIndex == 0{
                currentPageIndex = currentPageIndex + 1
                
                tabHeader1.text = HomePageTabs.sushi.rawValue
                tabHeader2.text = HomePageTabs.drinks.rawValue
                tabHeader3.text = HomePageTabs.pizza.rawValue
                
                
                pizzaContainerViewTab.alpha = 0
                sushiContainerViewTab.alpha = 1
                
            }
           
        }
        
        if sender.direction == .right {
            
            
            if currentPageIndex == 0{
                currentPageIndex = 2
                
                tabHeader1.text = HomePageTabs.drinks.rawValue
                tabHeader2.text = HomePageTabs.pizza.rawValue
                tabHeader3.text = HomePageTabs.sushi.rawValue
                
            
                
                DrinksContainerViewTab.alpha = 1
                pizzaContainerViewTab.alpha = 0
                
            }else if currentPageIndex == 1{
                currentPageIndex = currentPageIndex - 1
                
                tabHeader1.text = HomePageTabs.pizza.rawValue
                tabHeader2.text = HomePageTabs.sushi.rawValue
                tabHeader3.text = HomePageTabs.drinks.rawValue
                
                pizzaContainerViewTab.alpha = 1
                sushiContainerViewTab.alpha = 0
                
                
            }else if currentPageIndex == 2{
                currentPageIndex = currentPageIndex - 1
                
                tabHeader1.text = HomePageTabs.sushi.rawValue
                tabHeader2.text = HomePageTabs.drinks.rawValue
                tabHeader3.text = HomePageTabs.pizza.rawValue
                
                sushiContainerViewTab.alpha = 1
                DrinksContainerViewTab.alpha = 0
                
                
                
                
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
