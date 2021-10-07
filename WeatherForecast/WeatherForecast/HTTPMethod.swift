//
//  HTTPMethod.swift
//  WeatherForecast
//
//  Created by 이윤주 on 2021/10/01.
//

import Foundation

//enum ParsingType {
//    case currentWeather
//    case fiveDayForecast
//
//    var model: WeatherType {
//        switch self {
//        case .currentWeather:
//            return CurrentWeather.self
//        case .fiveDayForecast:
//            return FiveDayForecast.self
//        }
//    }
//}

protocol TestProtocol: AnyObject {
    func success<T: Decodable>(model: T)
}

class HTTPMethod {
    let networkManager = NetworkManager()
    let parsingManager = ParsingManager()
    var delegate: TestProtocol?
    
    func getWeatherData<T: Decodable>(url: URL, model: T.Type, competion: @escaping (T) -> Void) {
        networkManager.request(url: url) { result in
            switch result {
            case .success(let data):
                let jsonData = self.parsingManager.parse(data, to: model.self)
                switch jsonData {
                case .success(let modelType):
                    competion(modelType)
                case .failure(let error):
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

//    func fetchWeatherData(type: Weather)
//    type.model
//
//    fetchWeatherData(type: .current)
//
//    enum Weather {
//        case current
//        case forecast
//
//        var parsedData: Decodable {
//            switch self {
//            case .current:
//                return
//            }
//        }
//    }
    
//    func getFiveDayForecast(url: URL) {
//        networkManager.request(url: url) { result in
//            switch result {
//            case .success(let data):
//                let jsonData = self.parsingManager.parse(data, to: FiveDayForecast.self)
//                switch jsonData {
//                case .success(let fiveDayForecast):
//                    print(fiveDayForecast)
//                case .failure(let error):
//                    print(error)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
//    func getWeather<T: Decodable>(url: URL, type: Decodable) -> T {
//        networkManager.request(url: url) { result in
//            switch result {
//            case .success(let data):
//                let json = self.parsingManager.parse(data, to: T.self)
//                return json
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
//    let currentWeather: CurrentWeather = ParsingManager().parse(<#T##data: Data##Data#>, to: <#T##Decodable.Protocol#>)
    
//
//    func resultHandler<T: Decodable>(_ type: T.Type, result: Result<Data, NetworkError>) {
//        switch result {
//        case .success(let data):
//            let jsonData = self.parsingManager.parse(data, to: T.self)
//            switch jsonData {
//            case .success(let fiveDayForecast):
//                print(fiveDayForecast)
//            case .failure(let error):
//                print(error)
//            }
//        case .failure(let error):
//            print(error)
//        }
//    }
}
