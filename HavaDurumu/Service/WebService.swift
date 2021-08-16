//
//  WebService.swift
//  HavaDurumu
//
//  Created by Caner on 16.08.2021.
//

import Foundation
import Alamofire
class WebService {
    
    func getWeather(cityName:String,completion : @escaping ((ResponseModel)?) -> ()){
        // Türkçe karakterlerden sorununu çözmek için... çanakkale -> %C3%87anakkale
        // çanakkale olarak deneyince alamofire "invalid url" hatası veriyor.
        let urlString = "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=\(cityName)"
        let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: encoded!)
        
        // şimdi istek at
        let headers:HTTPHeaders = ["content-type": "application/json","authorization": "apikey 4IcMcbGGso5lSvSKtIk9pq:4BBs1Qu2AEYHd2F2aEnJw4"]
        AF.request(url!,headers: headers).responseJSON { response in
            switch response.result{
            case .success(_):
                if let data = response.data{
                    let weather = try? JSONDecoder().decode(ResponseModel.self, from: data)
                    completion(weather)
                    
                }else{
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
            
        }
    }
}
