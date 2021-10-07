//
//  URL.swift
//  WeatherForecast
//
//  Created by 이윤주 on 2021/09/29.
//

import Foundation

enum URLAPI {
    case getCurrent
    case getForecast
    
    var path: String {
        switch self {
        case .getCurrent:
            return "/data/2.5/weather"
        case .getForecast:
            return "/data/2.5/forecast"
        }
    }
}

extension URLAPI {
    func configure(latitude: Double, longitude: Double) -> URL? {
        let apiKey = "1af72e89e05d364984fe32463122135f"
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = self.path
        let lat = URLQueryItem(name: "lat", value: latitude.description)
        let lon = URLQueryItem(name: "lon", value: longitude.description)
        let appId = URLQueryItem(name: "appid", value: apiKey)
        urlComponents.queryItems = [lat, lon, appId]
        
        return urlComponents.url
    }
}



//case getCurrent(Double, Double)
//case getForecast(Double, Double)
//
//var path: String {
//    switch self {
//    case .getCurrent:
//        return "/data/2.5/weather"
//    case .getForecast:
//        return "/data/2.5/forecast"
//    }
//}
//
//var query: (Double, Double) {
//    switch self {
//    case .getCurrent(let latitude, let longitude):
//        return (latitude, longitude)
//    case .getForecast(let latitude, let longitude):
//        return (latitude, longitude)
//    }
//}
//}
