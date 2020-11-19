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
    
    
    @IBOutlet weak var pizzaTabTitle: UILabel!
    @IBOutlet weak var pizzaContainerViewTab: UIView!
    @IBOutlet weak var pizzaContainerViewTabHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var sushiTabTitle: UILabel!
    @IBOutlet weak var sushiContainerViewTab: UIView!
    @IBOutlet weak var sushiContainerViewTabHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var drinksTabTitle: UILabel!
    @IBOutlet weak var DrinksContainerViewTab: UIView!
    @IBOutlet weak var DrinksContainerViewTabHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var scrolleViewContentViewHeightConsttraints: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pagerView: AACarousel!
    
    
    var presenter: HomePresentation!
    var pizzaContainerViewController: PizzaContainerViewController!
    var currentIndex = 0
    
    
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
        
        pizzaTabTitle.textColor = UIColor.black
        sushiTabTitle.textColor = UIColor.gray
        drinksTabTitle.textColor = UIColor.gray
        
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
        
        
        //pizzaContainerViewController.setUpElements()
        
    }
    
    @objc func swipeMade(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            
            
            if currentIndex == 2{
                currentIndex = 0
            
                pizzaTabTitle.textColor = UIColor.black
                drinksTabTitle.textColor = UIColor.gray
                
                
                pizzaContainerViewTab.alpha = 1
                DrinksContainerViewTab.alpha = 0
                
            }else if currentIndex == 1{
                currentIndex = currentIndex + 1
                
                sushiTabTitle.textColor = UIColor.gray
                drinksTabTitle.textColor = UIColor.black
                
                sushiContainerViewTab.alpha = 0
                DrinksContainerViewTab.alpha = 1
            
            }else if currentIndex == 0{
                currentIndex = currentIndex + 1
                
                sushiTabTitle.textColor = UIColor.black
                pizzaTabTitle.textColor = UIColor.gray
                
                pizzaContainerViewTab.alpha = 0
                sushiContainerViewTab.alpha = 1
                
            }
           
        }
        
        if sender.direction == .right {
            
            
            if currentIndex == 0{
                currentIndex = 2
                
                drinksTabTitle.textColor = UIColor.black
                pizzaTabTitle.textColor = UIColor.gray
               
                
                DrinksContainerViewTab.alpha = 1
                pizzaContainerViewTab.alpha = 0
                
            }else if currentIndex == 1{
                currentIndex = currentIndex - 1
                
                sushiTabTitle.textColor = UIColor.gray
                pizzaTabTitle.textColor = UIColor.black
                
                pizzaContainerViewTab.alpha = 1
                sushiContainerViewTab.alpha = 0
                
                
            }else if currentIndex == 2{
                currentIndex = currentIndex - 1
                
                sushiTabTitle.textColor = UIColor.black
                drinksTabTitle.textColor = UIColor.gray
                
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
