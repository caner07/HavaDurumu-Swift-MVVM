//
//  HomeViewModel.swift
//  HavaDurumu
//
//  Created by Caner on 16.08.2021.
//

import Foundation
protocol HomeViewModelDelegate {
    func loading()
    func success(_ i:Int)
    
    func error()
}
class HomeViewModel{
    var delegate:HomeViewModelDelegate?
    let CITIES = "cities"
    var citiesList = [String]()
    var weathersList = [ResponseModel]()
    var selectedCity :ResponseModel?
    func getCities(){
        let d = UserDefaults.standard
        citiesList = d.object(forKey: CITIES) as? [String] ?? [String]()
        if citiesList.count != 0 {
            loadWeather()
        }
    }
    func loadWeather(){
        self.delegate?.loading()
        weathersList.removeAll()
        for city in citiesList{
            WebService().getWeather(cityName: city) { response in
                if let response = response{
                    self.weathersList.append(response)
                    self.delegate?.success(0)
                    
                    
                }
                
            }
        }
    }
    func deleteCity(_ city:Int){
        let d = UserDefaults.standard
        d.removeObject(forKey: CITIES)
        let removeItem = citiesList.firstIndex(of: weathersList[city].city)!
        citiesList.remove(at: removeItem)
        d.setValue(citiesList, forKey: CITIES)
        weathersList.remove(at: city)
    }
}
