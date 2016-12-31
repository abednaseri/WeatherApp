//
//  Forcast.swift
//  My Weather
//
//  Created by Abed on 25/12/2016.
//  Copyright © 2016 Webiaturist. All rights reserved.
//

import UIKit
import Alamofire

class Forcast{
    var _date: String!
    var _weatherType: String!
    var _min_Temp: Double!
    var _max_Temp: Double!
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var min_Temp: Double{
        if _min_Temp == nil{
            _min_Temp = 0.0
        }
        return _min_Temp
    }
    
    var max_Temp: Double{
        if _max_Temp == nil{
            _max_Temp = 0.0
        }
        return _max_Temp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>){
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
            
            if let min = temp["min"] as? Double{
                let celciusMin = round(Double(min - 273.15))
                self._min_Temp = celciusMin
            }
            
            if let max = temp["max"] as? Double{
                let celciusMax = round(Double(max - 273.15))
                self._max_Temp = celciusMax
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.DayOFTheWeek()
        }
    }
}



extension Date{
    func DayOFTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}






