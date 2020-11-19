//
//  PromoPackagesService.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
import Alamofire
import SwiftyJSON
import Moya

class PromoPackagesService {
    
    var promoOffersBannerImageList: [String] = []
    func fetchPromoPackagesBanner(completion: @escaping (_ result: [String] ) -> Void){
        let service = MoyaProvider<PromoPackageService.PromoProvider>()
        service.request(.getPromoBannerImages){ (result) in
            
            switch result {
            
            case .success(let response):
                
                do {

                    let json = try JSON(data: response.data)

                    if json["success"][0]["success"].string == "success"{
                        
                        for i in 0...json["result"].count {
                            
                            if json["result"][i].string != nil{
                                let bannerImageUrl = json["result"][i].string!
                                self.promoOffersBannerImageList.append(bannerImageUrl)
                            }
                            
                        }

                        completion(self.promoOffersBannerImageList)

                    } else {
                        completion(self.promoOffersBannerImageList)
                    }

                } catch let error as NSError {
                    completion(self.promoOffersBannerImageList)
                }
                
                
            case .failure(let error):
                print("fetch promoBanner error: \(error)")
            }
        }
    }
}

enum PromoPackageService{
    enum PromoProvider: TargetType {
        case getPromoBannerImages
        
        var baseURL: URL{
            return URL(string: Constants.Endpoints.baseUrl)!
        }
        
        var path: String{
            switch self{
            case .getPromoBannerImages:
                return Constants.Endpoints.getPromoBannerImagesExt
                
            }
        }
        
        var method: Moya.Method{
            return .post
        }
        
        var sampleData: Data{
            return Data()
        }
        
        var task: Task{
            switch self{
            
            case .getPromoBannerImages:
                return .requestPlain
            }
        }
        
        var headers: [String : String]? {
            return [:]
        }
        
    }
    
}







