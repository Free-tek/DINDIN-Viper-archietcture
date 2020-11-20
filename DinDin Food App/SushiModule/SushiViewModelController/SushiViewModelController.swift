//
//  SushiViewModelController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
import Moya
import SwiftyJSON
import RxSwift
import RxCocoa


class SushiViewModelController{
    
    var viewModels: BehaviorRelay<[SushiViewModel?]> = BehaviorRelay(value: [])
    
    
    func FetchSushiData(completion: @escaping (_ success: Bool) -> ()){
        let service = MoyaProvider<FetchSushiServiceAPI.FetchSushiProvider>()
        service.request(.getSushiData){ (result) in
            
            switch result {
            
            case .success(let response):
                
                
                do {

                    let json = try JSON(data: response.data)
                    var sushiModel = [SushiModel?]()
                    
                    
                    if json["success"][0]["success"].string == "success" && json["error"][0]["error"].string != "invalid token"{
                        for i in 0...json["result"].count - 1 {
                            
                            
                            let susshiImage = json["result"][i]["food_image"].string
                            let susshiName = json["result"][i]["food_name"].string
                            let susshiDescription = json["result"][0]["food_description"].string
                            let susshiPrice = json["result"][i]["food_price"].int
                            let susshiStoreId =  "SS\(i)"
                            
                            
                            let itemGotten = SushiModel(susshiName: susshiName, susshiImage: susshiImage, susshiDescription: susshiDescription, susshiStoreId: susshiStoreId, susshiPrice: susshiPrice)
                            
                            sushiModel.append(itemGotten)
                        }

                        self.viewModels = BehaviorRelay(value: self.initViewModels(sushiModel))
                        completion(true)

                    } else {
                        
                        completion(false)
                    }

                } catch let error as NSError {
                    completion(false)
                }
                
                
            case .failure(let error):
                
                completion(false)
            }
        }
    }
    
    var viewModelsCount: Int {
        return viewModels.value.count
    }
    
    var allViewModels: [SushiViewModel?] {
        return viewModels.value
    }

    func viewModel(at index: Int) -> SushiViewModel? {
        guard index >= 0 && index < viewModelsCount else { return nil }
        return viewModels.value[index]
    }


    func initViewModels(_ sushiModel: [SushiModel?]) -> [SushiViewModel?] {
        return sushiModel.map { sushi in
            if let sushi = sushi {
                return SushiViewModel(sushiModel: sushi)
            } else {
                return nil
            }
        }
    }
    
}


enum FetchSushiServiceAPI{
    
    enum FetchSushiProvider: TargetType {
        case getSushiData
        
        var baseURL: URL{
            return URL(string: Constants.Endpoints.baseUrl)!
        }
        
        var path: String{
            switch self{
            case .getSushiData:
                return Constants.Endpoints.fetchSushiList
                
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
            
            case .getSushiData:
                return .requestParameters(parameters: ["startIndex":"all", "count":"all"], encoding: URLEncoding.default)
            }
        }
        
        var headers: [String : String]? {
            return [:]
        }
        
    }
    
}


