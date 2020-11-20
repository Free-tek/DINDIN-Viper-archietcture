//
//  DrinksViewModelController.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
import Moya
import SwiftyJSON


class DrinksViewModelController{
    
    var viewModels: [DrinksViewModel?] = []
    
    func FetchDrinksData(completion: @escaping (_ success: Bool) -> ()){
        let service = MoyaProvider<FetchDrinksServiceAPI.FetchDrinksProvider>()
        service.request(.getDrinksData){ (result) in
            
            switch result {
            
            case .success(let response):
                
                
                do {

                    let json = try JSON(data: response.data)
                    var drinksModel = [DrinksModel?]()
                    
                    
                    if json["success"][0]["success"].string == "success" && json["error"][0]["error"].string != "invalid token"{
                        for i in 0...json["result"].count - 1 {
                            
                            
                            let drinksImage = json["result"][i]["food_image"].string
                            let drinksName = json["result"][i]["food_name"].string
                            let drinksDescription = json["result"][0]["food_description"].string
                            let drinksPrice = json["result"][i]["food_price"].int
                            let drinksStoreId =  "DK\(i)"
                            
                            
                            let itemGotten = DrinksModel(drinksName: drinksName, drinksImage: drinksImage, drinksDescription: drinksDescription, drinksStoreId: drinksStoreId, drinksPrice: drinksPrice)
                            
                            drinksModel.append(itemGotten)
                        }

                        self.viewModels = self.initViewModels(drinksModel)
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
        return viewModels.count
    }
    
    var allViewModels: [DrinksViewModel?] {
        return viewModels
    }

    func viewModel(at index: Int) -> DrinksViewModel? {
        guard index >= 0 && index < viewModelsCount else { return nil }
        return viewModels[index]
    }


    func initViewModels(_ drinksModel: [DrinksModel?]) -> [DrinksViewModel?] {
        return drinksModel.map { drinks in
            if let drinks = drinks {
                return DrinksViewModel(drinksModel: drinks)
            } else {
                return nil
            }
        }
    }
    
}


enum FetchDrinksServiceAPI{
    
    enum FetchDrinksProvider: TargetType {
        case getDrinksData
        
        var baseURL: URL{
            return URL(string: Constants.Endpoints.baseUrl)!
        }
        
        var path: String{
            switch self{
            case .getDrinksData:
                return Constants.Endpoints.fetchDrinksList
                
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
            
            case .getDrinksData:
                return .requestParameters(parameters: ["startIndex":"all", "count":"all"], encoding: URLEncoding.default)
            }
        }
        
        var headers: [String : String]? {
            return [:]
        }
        
    }
    
}

