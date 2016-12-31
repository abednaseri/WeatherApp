//
//  Location.swift
//  My Weather
//
//  Created by Abed on 27/12/2016.
//  Copyright © 2016 Webiaturist. All rights reserved.
//

import CoreLocation

class Location{
    static var SharedInstance = Location()
    private init() {}
    
    var Longitude: Double!
    var Latitude: Double!
}

