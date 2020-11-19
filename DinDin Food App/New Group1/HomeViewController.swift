//
//  HomeViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import UIKit
import AACarousel
import  Kingfisher

protocol HomeView: class {
    
    func setUpElements() -> (Void)
    
    func setUpPromoOffersView(promoBannerImages: [String]) -> (Void)
}

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var menuViewBoundaryView: UIView!
    @IBOutlet weak var menuViewBoundaryViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var menuContainerViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var scrolleViewContentViewHeightConsttraints: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pagerView: AACarousel!
    
    
    var presenter: HomePresentation!
    var promoOffersViewController: PromoOffersViewController!
    
    
    enum Segues{
        static let toPromoOffers = "toPromoOffers"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.viewDidLoad()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == Segues.toPromoOffers{
            promoOffersViewController = segue.destination as! PromoOffersViewController
        }
        
    }
    

    
    
}

extension HomeViewController: HomeView{
    
    
    func setUpElements(){
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let ScreenHeight = screenSize.height
        
        menuViewBoundaryViewConstraint.constant = ScreenHeight
        menuViewBoundaryView.layoutIfNeeded()
        
        menuViewBoundaryView.layer.cornerRadius = 35
        menuViewBoundaryView.layer.masksToBounds = true
        
        menuContainerViewHeightConstraints.constant = ScreenHeight
        menuContainerView.layoutIfNeeded()
        
        
        scrolleViewContentViewHeightConsttraints.constant = ScreenHeight + pagerView.bounds.height
        
        scrollViewContentView.layoutIfNeeded()
        
        
        scrollViewHeightConstraint.constant = ScreenHeight + pagerView.bounds.height
        
        scrollView.layoutIfNeeded()
        
        
    }
    
    func setUpPromoOffersView(promoBannerImages: [String]){
        
        let pathArray = promoBannerImages
                
        pagerView.delegate = self
        pagerView.setCarouselData(paths: pathArray,  describedTitle: [], isAutoScroll: true, timer: 3.0, defaultImage: "defaultImage")
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
