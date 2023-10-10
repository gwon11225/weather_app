//
//  WeatherResponse.swift
//  todaktodak
//
//  Created by Jiyoung on 10/10/23.
//

import Foundation

struct WeatherResponse: Codable {
    let weather: [WeatherInfo]
    let main: MainInfo
    let city: String
    
    private enum CodingKeys: String, CodingKey {
        case weather = "weather"
        case main = "main"
        case city = "name"
    }
}

struct WeatherInfo: Codable {
    let main: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
    }
}

struct MainInfo: Codable {
    let temp: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
    }
}
