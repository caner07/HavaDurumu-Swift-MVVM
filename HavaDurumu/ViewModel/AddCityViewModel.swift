//
//  AddCityViewModel.swift
//  HavaDurumu
//
//  Created by Caner on 16.08.2021.
//

import Foundation
protocol AddCityViewModelDelegate {
    func loading()
    func error()
    func updateCities()
    func done()
}
class AddCityViewModel{
    var delegate:AddCityViewModelDelegate?
    var allCities = [String]()
    var filteredData = [String]()
    let CITIES = "cities"
    
    func getCities(){
        delegate?.loading()
        if let citiesPath = Bundle.main.path(forResource: "cities", ofType: "txt") {
            if let city = try? String(contentsOfFile: citiesPath) {
                allCities = city.components(separatedBy: "\n")
            }
        } else {
            allCities = [""]
        }
        filteredData = allCities
        delegate?.updateCities()
    }
    func searchCity(_ searchText:String){
        filteredData = searchText.isEmpty ? allCities : allCities.filter({(dataString: String) -> Bool in
                // If dataItem matches the searchText, return true to include it
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })

        delegate?.updateCities()
    }
    func saveCity(cityName:String){
        let d = UserDefaults.standard
        var cities = d.object(forKey: CITIES) as? [String]
        cities?.append(cityName)
        d.setValue(cities, forKey: CITIES)
        delegate?.done()
    }
}


