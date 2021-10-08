//
//  WeatherForecastTests - WeatherForecastTests.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import XCTest
@testable import WeatherForecast

class WeatherForecastTests: XCTestCase {
    
    let parsingManager = ParsingManager()
    
//    func test_JSON파일인CurrentWeather를_디코딩했을때_id는420006353이다() {
//        //given
//        let outputValue: Int?
//        let expectedValue = 420006353
//        let path = Bundle(for: type(of: self)).path(forResource: "CurrentWeather", ofType: "json")
//        let jsonFile = try! String(contentsOfFile: path!).data(using: .utf8)
//        //when
//        let data = parsingManager.parse(jsonFile!, to: CurrentWeather.self)
//        switch data {
//        case .success(let currentWeather):
//            outputValue = currentWeather.id
//        case .failure(_):
//            outputValue = -1
//        }
//        //then
//        XCTAssertEqual(expectedValue, outputValue)
//    }
//    
//    func test_JSON파일인FiveDayWeather를_디코딩했을때_id는2643743이다() {
//        //given
//        let outputValue: Int?
//        let expectedValue = 2643743
//        let path = Bundle(for: type(of: self)).path(forResource: "FiveDayWeather", ofType: "json")
//        let jsonFile = try! String(contentsOfFile: path!).data(using: .utf8)
//        //when
//        let data = parsingManager.parse(jsonFile!, to: FiveDayForecast.self)
//        switch data {
//        case .success(let fiveDayWeather):
//            outputValue = fiveDayWeather.city?.id
//        case .failure(_):
//            outputValue = -1
//        }
//        //then
//        XCTAssertEqual(expectedValue, outputValue)
//    }
//    
//    func test_mock통신이_성공한다() {
//        //given
//        let path = Bundle(for: type(of: self)).path(forResource: "CurrentWeather", ofType: "json")
//        let jsonFile = try! String(contentsOfFile: path!).data(using: .utf8)
//        let url = URL(string: "www.test.com")
//        let session = MockURLSession(isSuccess: true, data: jsonFile)
//        let networkManager = NetworkManager(session: session)
//        
//        //when
//        networkManager.request(url: url!) { result in
//            //then
//            switch result {
//            case .success:
//                XCTAssertTrue(true)
//            case .failure:
//                XCTFail()
//            }
//        }
//    }
//    
//    func test_mock통신이_실패한다() {
//        //given
//        let path = Bundle(for: type(of: self)).path(forResource: "CurrentWeather", ofType: "json")
//        let jsonFile = try! String(contentsOfFile: path!).data(using: .utf8)
//        let url = URL(string: "www.test.com")
//        let session = MockURLSession(isSuccess: false, data: jsonFile)
//        let networkManager = NetworkManager(session: session)
//        
//        //when
//        networkManager.request(url: url!) { result in
//            //then
//            switch result {
//            case .success:
//                XCTFail()
//            case .failure:
//                XCTAssertTrue(true)
//            }
//        }
//    }
    
    func test_실제네트워크통신_성공() {
        var outputValue: String?
        let expectedValue = "Banpobondong"
        let networkManager = NetworkManager<WeatherRequest>()
        networkManager.request(of: .getCurrent(37.478055, 126.961595)) { result in
            switch result {
            case .success(let data):
                let parsedData = self.parsingManager.parse(data, model: CurrentWeather.self)
                switch parsedData {
                case .success(let curretWeather):
                    outputValue = curretWeather.name
                case .failure(let error):
                    XCTFail()
                }
            case .failure(let error):
                XCTFail()
            }
        }
        XCTAssertEqual(outputValue, expectedValue)
    }

}
