//
//  NetworkError.swift
//  WeatherForecast
//
//  Created by 이윤주 on 2021/10/08.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case requestFail
    case failedStatusCode
    case emptyData
    
    var errorDescription: String? {
        switch self {
        case .requestFail:
            return "요청이 실패했습니다."
        case .failedStatusCode:
        return "실패 상태 코드가 전달되었습니다."
        case .emptyData:
            return "데이터가 존재하지 않습니다."
        }
    }
}
