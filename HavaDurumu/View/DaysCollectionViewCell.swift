//
//  DaysCollectionViewCell.swift
//  HavaDurumu
//
//  Created by Caner on 19.08.2021.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayIcon: UIImageView!
    @IBOutlet weak var dayDegreeLabel: UILabel!
    
    func setUI(day:String,description:String,degree:String){
        
        dayLabel.text = day
        dayDegreeLabel.text = "\(degree.prefix(2))°"
        
        if description.contains("yağmur") {
            dayIcon.image = UIImage(named: "yagmur")}
        if description.contains("bulut"){
            dayIcon.image = UIImage(named: "parcali_bulutlu_gunduz")}
        else{
            dayIcon.image = UIImage(named: "acik_gunduz")
            }
    }
}
