//
//  Model.swift
//  Veather
//
//  Created by Vedant Patle on 16/08/25.
//

import Foundation

struct APIResponse: Codable {
    var weather: [Weather]
    var main: Main
    var wind: Wind
    var sys: Sys
    var name: String?
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main: Codable {
    var temp: Double?
    var tempMin: Double?
    var tempMax: Double?
    var humidity: Int?
    
    private enum codingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Wind: Codable {
    var speed: Double?
    var deg: Double?
    var gust: Double?
}

struct Sys: Codable {
    var country: String?
}

