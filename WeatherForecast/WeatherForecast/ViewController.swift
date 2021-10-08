//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var currentWeatherLabel: UILabel!
    // 싱글턴?
    let networkManager = NetworkManager<WeatherRequest>()
    let parsingManager = ParsingManager()
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
            
            
            DispatchQueue.main.async {
                self.currentWeatherLabel.text = self.currentWeather?.name
            }

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
    func fetchCurrentWeather(of location: Location) {
        print("2")
        networkManager.request(of: .getCurrent(latitude: location.latitude, longitude: location.latitude)) { result in
            switch result {
            case .success(let data):
                let parsedData = self.parsingManager.parse(data, model: CurrentWeather.self)
                switch parsedData {
                case .success(let currentWeatherData):
                    self.currentWeather = currentWeatherData
                case .failure(let error):
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    func fetchFiveDatForecast() {
//        networkManager.request(of: .getForecast) { result in
//            switch result {
//            case .success(let data):
//                let parsedData = self.parsingManager.parse1(data, model: FiveDayForecast.self)
//                switch parsedData {
//                case .success(let fiveDayForecastData):
//                    self.fiveDayForecast = fiveDayForecastData
//                case .failure(let error):
//                    print(error)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}

struct Location {
    let latitude: Double
    let longitude: Double
}
