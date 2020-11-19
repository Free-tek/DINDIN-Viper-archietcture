//
//  PromoOffersDataViewController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/18/20.
//

import UIKit
import Kingfisher


class PromoOffersDataViewController: UIViewController {

    @IBOutlet weak var promoOfferImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpPromoOfferImage()
    }
    
    
    func setUpPromoOfferImage(){
        
        
    }


}

extension UIImageView {
    
    func setImage(with urlString: String) {
        
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
        
    }

}
