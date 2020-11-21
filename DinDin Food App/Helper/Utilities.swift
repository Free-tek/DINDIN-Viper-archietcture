//
//  Utilities.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/21/20.
//

import Foundation
import UIKit

class Utilities{
    
    static func swapContainerViewsLeftSlide(slideOutView: UIView, slideInView: UIView, view: UIViewController){
        
        slideInView.center.x += self.view.bounds.width
        slideOutView.alpha = 1
        slideInView.alpha = 1
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.25, options: .beginFromCurrentState, animations: {
            slideOutView.center.x -= self.view.bounds.width
            slideInView.center.x -= self.view.bounds.width

        }, completion: { (finished: Bool) -> Void in
            slideOutView.alpha = 0
            slideInView.alpha = 1
            slideOutView.center.x += self.view.bounds.width

        })
    
    }
    
    
    static func swapContainerViewsRightSlide(slideOutView: UIView, slideInView: UIView){
        
        slideInView.center.x -= self.view.bounds.width
        slideOutView.alpha = 1
        slideInView.alpha = 1
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
