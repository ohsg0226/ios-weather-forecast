//
//  Requestable.swift
//  WeatherForecast
//
//  Created by 이윤주 on 2021/10/08.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    
    func configure() -> URLRequest?
}
