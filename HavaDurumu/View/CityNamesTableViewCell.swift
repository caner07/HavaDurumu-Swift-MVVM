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
            if description.contains("yağmur") {
                weatherIconName = "rain"
            }else if description.contains("bulut"){
                weatherIconName = "cloud"
            }else{
                weatherIconName = "moon"
            }
        }else{
            if description.contains("yağmur") {
                weatherIconName = "rain"
            }else if description.contains("bulut"){
                weatherIconName = "cloudy"
            }else{
                weatherIconName = "sun"
            }
        }
        weatherIcon.image = UIImage(named: weatherIconName)
        
        
    }
    func isItNight() -> Bool{
        let hour = Calendar.current.component(.hour, from: Date())
//        GÜNDÜZ
        if hour > 6 && hour < 18 {
            let image = UIImage(named: "DayBackground")
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleToFill
            self.backgroundView = imageView
            return false
        }
//        GECE
        let image = UIImage(named: "NightBackground")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        self.backgroundView = imageView
        return true
    }

}
