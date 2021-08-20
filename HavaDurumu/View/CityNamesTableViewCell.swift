//
//  CityNamesTableViewCell.swift
//  HavaDurumu
//
//  Created by Caner on 13.08.2021.
//

import UIKit

class CityNamesTableViewCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    var weatherIconName:String!
    var backgroundName:String!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI(cityName:String,degree:String,description:String){
        cityNameLabel.text = cityName
        degreeLabel.text = degree
        if isItNight() {
            setNightUI(description)
        }else{
            setDayUI(description)
        }
    }
    func isItNight() -> Bool{
        let hour = Calendar.current.component(.hour, from: Date())
//        GÜNDÜZ
        if hour > 6 && hour < 18 {
            
            return false
        }
//        GECE
        
        return true
    }
    func setNightUI(_ description:String){
        if description.contains("yağmur") {
            weatherIconName = "yagmur"
            backgroundName = "yagmurlu_gece_bg"
        }else if description.contains("bulut"){
            weatherIconName = "parcali_bulutlu_gece"
            backgroundName = "parcali_bulutlu_gece_bg"
        }else{
            weatherIconName = "acik_gece"
            backgroundName = "acik_gece_bg"
        }
        let image = UIImage(named: backgroundName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        self.backgroundView = imageView
        weatherIcon.image = UIImage(named: weatherIconName)
    }
    
    
    func setDayUI(_ description:String){
        if description.contains("yağmur") {
            weatherIconName = "yagmur"
            backgroundName = "yagmurlu_gunduz_bg"
        }else if description.contains("bulut"){
            weatherIconName = "parcali_bulutlu_gunduz"
            backgroundName = "parcali_bulutlu_gunduz_bg"
        }else{
            weatherIconName = "acik_gunduz"
            backgroundName = "acik_gunduz_bg"
        }
        let image = UIImage(named: backgroundName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        self.backgroundView = imageView
        weatherIcon.image = UIImage(named: weatherIconName)
    }
    
}
