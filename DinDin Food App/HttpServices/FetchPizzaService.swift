//
//  FetchPizzaService.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
import  Moya
import SwiftyJSON

class FetchPizzaService {
    
    var viewModels: [PizzaViewModel?] = []
    
    func FetchPizzaData(completion: @escaping (_ success: Bool) -> ()){
        let service = MoyaProvider<PromoPackageService.PromoProvider>()
        service.request(.getPromoBannerImages){ (result) in
            
            switch result {
            
            case .success(let response):
                
                do {

                    let json = try JSON(data: response.data)
                    var pizzaModel = [PizzaModel?]()
                    
                    
                    if json["success"][0]["success"].string == "success" && json["error"][0]["error"].string != "invalid token"{
                        for i in 0...json["result"].count - 1 {
                            
                            
                            let pizzaImage = json["result"][i]["food_image"].string
                            let pizzaName = json["result"][i]["food_name"].string
                            let pizzaDescription = json["result"][0]["food_description"].string
                            let pizzaPrice = json["result"][i]["food_price"].int
                            let pizzaStoreId =  "pizzaSK\(i)"
                            
                            
                            let itemGotten = PizzaModel(pizzaName: pizzaName, pizzaImage: pizzaImage, pizzaDescription: pizzaDescription, pizzaStoreId: pizzaStoreId, pizzaPrice: pizzaPrice)
                            
                            pizzaModel.append(itemGotten)
                        }

                        self.viewModels = self.initViewModels(pizzaModel)
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

    func viewModel(at index: Int) -> PizzaViewModel? {
        guard index >= 0 && index < viewModelsCount else { return nil }
        return viewModels[index]
    }


    func initViewModels(_ pizzaModel: [PizzaModel?]) -> [PizzaViewModel?] {
        return pizzaModel.map { pizza in
            if let pizza = pizza {
                return PizzaViewModel(pizzaModel: pizza)
            } else {
                return nil
            }
        }
    }
    
}


enum FetchPizzaServiceAPI{
    
    enum FetchPizzaProvider: TargetType {
        case getPizzaData
        
        var baseURL: URL{
            return URL(string: Constants.Endpoints.baseUrl)!
        }
        
        var path: String{
            switch self{
            case .getPizzaData:
                return Constants.Endpoints.fetchFoodList
                
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
            
            case .getPizzaData:
                return .requestParameters(parameters: ["startIndex":"all", "count":"all"], encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]? {
            return [:]
        }
        
    }
    
}


