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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
