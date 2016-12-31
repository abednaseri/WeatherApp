//
//  WeatherCell.swift
//  My Weather
//
//  Created by Abed on 26/12/2016.
//  Copyright © 2016 Webiaturist. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    
    func configureCell(forcast: Forcast){
        weatherIcon.image = UIImage(named: forcast.weatherType)
        dayLabel.text = forcast.date
        weatherTypeLbl.text = forcast.weatherType
        maxTempLbl.text = "\(Int(forcast.max_Temp))°"
        minTempLbl.text = "\(Int(forcast.min_Temp))°"
    }

    
}
