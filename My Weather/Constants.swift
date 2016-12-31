//
//  Constants.swift
//  My Weather
//
//  Created by Abed on 22/12/2016.
//  Copyright © 2016 Webiaturist. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUTE = "lat="
let LONGITUTE = "&lon="
let API_ID = "&appid="
let API_KEY = "e1322918754fc48f7f5806937b582e85"

typealias DownloadComplete = () -> () 

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUTE)\(Location.SharedInstance.Latitude!)\(LONGITUTE)\(Location.SharedInstance.Longitude!)\(API_ID)\(API_KEY)"

let FORCAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.SharedInstance.Latitude!)&lon=\(Location.SharedInstance.Longitude!)&cnt=16&mode=json&appid=e1322918754fc48f7f5806937b582e85"
