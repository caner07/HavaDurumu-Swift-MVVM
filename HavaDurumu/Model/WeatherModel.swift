//
//  ResultModel.swift
//  HavaDurumu
//
//  Created by Caner on 16.08.2021.
//

import Foundation

struct ResponseModel:Decodable {
    let city:String
    let result:[WeatherModel]
}

struct WeatherModel:Decodable {
    let date:String?
    let day:String?
    let icon:String?
    let description:String?
    let degree:String?
    let min:String?
    let max:String?
    let humidity:String?
}
