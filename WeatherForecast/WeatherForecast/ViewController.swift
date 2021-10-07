//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import CoreLocation

class ViewController: UIViewController {
    // 싱글턴?
    let httpMethod = HTTPMethod()
    var locationManager: CLLocationManager?
    
    var currentWeather: CurrentWeather?
    var fiveDayForecast: FiveDayForecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first {
            let latitude = coordinate.coordinate.latitude
            let longitude = coordinate.coordinate.longitude
            
            getCurrentWeatherData(of: Location(latitude: latitude, longitude: longitude))
            getFiveDayForecastData(latitude: latitude, longitude: longitude)
            
            let findLocation = CLLocation(latitude: latitude, longitude: longitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr")
            geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
                if let address: [CLPlacemark] = placemarks {
                    print(address.first?.administrativeArea)
                    print(address.first?.locality)
                    print(address.first?.subLocality)
                }
            })
        }
    }
}

extension ViewController {
    func getCurrentWeatherData(of location: Location) {
        guard let url = URLAPI.getCurrent.configure(latitude: location.latitude, longitude: location.latitude) else {
            return
        }
        httpMethod.getWeatherData(url: url, model: CurrentWeather.self) { model in
            self.currentWeather = model
        }
    }
    
    func getFiveDayForecastData(latitude: Double, longitude: Double) {
        guard let url = URLAPI.getForecast.configure(latitude: latitude, longitude: longitude) else {
            return
        }
        httpMethod.getWeatherData(url: url, model: FiveDayForecast.self) { model in
            self.fiveDayForecast = model
        }
    }
}

struct Location {
    let latitude: Double
    let longitude: Double
}
