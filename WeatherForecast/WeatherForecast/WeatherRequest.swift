//
//  URL.swift
//  WeatherForecast
//
//  Created by 이윤주 on 2021/09/29.
//

import Foundation

enum WeatherRequest: Requestable {
    case getCurrent(latitude: Double, longitude: Double)
    case getForecast(latitude: Double, longitude: Double)
    
    var baseURL: String {
        return "https://api.openweathermap.org"
    }
    
    var path: String {
        switch self {
        case .getCurrent:
            return "/data/2.5/weather"
        case .getForecast:
            return "/data/2.5/forecast"
        }
    }
    
    var query: (Double, Double) {
        switch self {
        case .getCurrent(latitude: let latitude, longitude: let longitude):
            return (latitude, longitude)
        case .getForecast(latitude: let latitude, longitude: let longitude):
            return (latitude, longitude)
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}

extension WeatherRequest {
    func configure() -> URLRequest? {
        let apiKey = "1af72e89e05d364984fe32463122135f"
        var urlComponents = URLComponents(string: self.baseURL)
        urlComponents?.path = self.path
        let lat = URLQueryItem(name: "lat", value: self.query.0.description)
        let lon = URLQueryItem(name: "lon", value: self.query.1.description)
        let appId = URLQueryItem(name: "appid", value: apiKey)
        urlComponents?.queryItems = [lat, lon, appId]
        guard let url = urlComponents?.url else {
            return nil
        }
        print("\(url)👍")
        print(self.query)
        return URLRequest(url: url)
    }
    
//    func configure(latitude: Double, longitude: Double) -> URL? {
//        let apiKey = "1af72e89e05d364984fe32463122135f"
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.openweathermap.org"
//        urlComponents.path = self.path
//        let lat = URLQueryItem(name: "lat", value: latitude.description)
//        let lon = URLQueryItem(name: "lon", value: longitude.description)
//        let appId = URLQueryItem(name: "appid", value: apiKey)
//        urlComponents.queryItems = [lat, lon, appId]
//
//        return urlComponents.url
//    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
    
    var name: String {
        return self.rawValue
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
