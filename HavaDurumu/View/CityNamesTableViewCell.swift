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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI(cityName:String,degree:String){
        cityNameLabel.text = cityName
        degreeLabel.text = degree
        let image = UIImage(named: "DayBackground")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        self.backgroundView = imageView
    }

}
