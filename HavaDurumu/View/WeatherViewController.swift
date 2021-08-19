//
//  WeatherViewController.swift
//  HavaDurumu
//
//  Created by Caner on 18.08.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var minDegreeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxDegreeLabel: UILabel!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    var weather:ResponseModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self

    }
    
    func setUI(){
        let todayWeather = weather.result[0]
        navigationItem.title = weather.city
        descriptionLabel.text = todayWeather.description?.uppercased()
        degreeLabel.text = "\(todayWeather.degree!.prefix(2))°"
        maxDegreeLabel.text = "\(todayWeather.max!.prefix(2))°"
        minDegreeLabel.text = "\(todayWeather.min!.prefix(2))°"
        humidityLabel.text = "% \(todayWeather.humidity!.prefix(2))"
        
        if todayWeather.description!.contains("yağmur") {
            weatherIconImageView.image = UIImage(named: "rain")
            return
        }
        if isItNight() {
            if todayWeather.description!.contains("bulut"){
                weatherIconImageView.image = UIImage(named: "cloud")
            }else{
                weatherIconImageView.image = UIImage(named: "moon")
            }
        }
//        gündüz
        else{
            if todayWeather.description!.contains("bulut"){
                weatherIconImageView.image = UIImage(named: "cloudy")
            }else{
                weatherIconImageView.image = UIImage(named: "sun")
            }
        }
        
    }
    func isItNight()->Bool{
        let hour = Calendar.current.component(.hour, from: Date())
        print(hour)
        if hour > 6 && hour < 18 {
            return false
        }
        return true
        
    }

}
extension WeatherViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day", for: indexPath) as! DaysCollectionViewCell
        let day = weather.result[indexPath.row]
        cell.setUI(day: day.day!, description: day.description!, degree: day.degree!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/1.2, height: 70)
    }
    
    
}
