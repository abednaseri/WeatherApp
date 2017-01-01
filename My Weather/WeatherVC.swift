//
//  WeatherVC.swift
//  My Weather
//
//  Created by Abed on 20/12/2016.
//  Copyright © 2016 Webiaturist. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    // Declaring IBOutlets
    @IBOutlet weak var currentDateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var LocationLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeathertypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forcast: Forcast!
    var forcast_array = [Forcast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    
    
    
    

    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.SharedInstance.Latitude = currentLocation?.coordinate.latitude
            Location.SharedInstance.Longitude = currentLocation?.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForcastDetails {
                    self.updateTheMainUI()
                }
            }

            
            
        } else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForcastDetails(completed: @escaping DownloadComplete){
        //Downloading Forcast weather data for TableView
        Alamofire.request(FORCAST_WEATHER_URL).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    
                    for obj in list{
                        let forcast = Forcast(weatherDict: obj)
                        self.forcast_array.append(forcast)
                    }
                    self.forcast_array.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcast_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            let forecast = forcast_array[indexPath.row]
            cell.configureCell(forcast: forecast)
            return cell
        
        } else{
            return WeatherCell()
        }
    }
    
    func updateTheMainUI(){
        currentDateLbl.text = currentWeather.date
        currentTempLbl.text = "\(Int(currentWeather.currentTemp))°"
        LocationLbl.text = currentWeather.cityName
        currentWeathertypeLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }


}

