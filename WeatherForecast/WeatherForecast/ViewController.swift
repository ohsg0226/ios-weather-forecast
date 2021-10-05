//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import CoreLocation

class ViewController: UIViewController {
    // 싱글턴?
    let networkManager = NetworkManager()
    var locationManager: CLLocationManager?
    
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
//            URLAPI.getCurrent.configure(latitude: <#T##Double#>, longitude: <#T##Double#>)
            let findLocation = CLLocation(latitude: 37.540846, longitude: 126.971757)
//            let findLocation = CLLocation(latitude: latitude, longitude: longitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr")
            geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
                if let address: [CLPlacemark] = placemarks {
//                    print(address.last?.addressDictionary!["State"]) as? String
//                    print(address.last?.timeZone)
                    print(address.last?.administrativeArea)
                    print(address.last?.locality)
                    print(address.last?.subLocality)
                    print(address.last?.name)
//                    if let name: String = address.last?.name { print(name) } //전체 주소
                }
            })
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
}

//enum Weather {
//    case getCurrent
//    case getForecast
//
//    var modelType: Decodable {
//        switch self {
//        case .getCurrent:
//            return CurrentWeather
//        case .getForecast:
//            return FiveDayForecast
//        }
//    }
//}
//
//extension ViewController {
//    func getWeather(type: )
//}
