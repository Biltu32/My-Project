//
//  Weather.swift
//  Weather
//
//  Created by DAPL-Asset-210 on 12/07/24.
//


import Foundation

// MARK: - Weather
struct Weather: Codable {
    let queryCost: Int?
    let latitude, longitude: Double?
    let resolvedAddress, address, timezone: String?
    let tzoffset: Double?
    let description: String?
    let days: [CurrentConditions]?
    let stations: Stations?
    let currentConditions: CurrentConditions?
}

// MARK: - CurrentConditions
struct CurrentConditions: Codable {
    let datetime: String?
    let datetimeEpoch: Int?
    let temp, feelslike, humidity, dew: Double?
    let precip: Double?
    let precipprob: Double?
    let snow, snowdepth: Int?
    let preciptype: [Icon]?
    let windgust: Double?
    let windspeed, winddir, pressure, visibility: Double?
    let cloudcover, solarradiation, solarenergy: Double?
    let uvindex: Int?
    let conditions: Conditions?
    let icon: Icon?
    let stations: [ID]?
    let source: Source?
    let sunrise: String?
    let sunriseEpoch: Int?
    let sunset: String?
    let sunsetEpoch: Int?
    let moonphase, tempmax, tempmin, feelslikemax: Double?
    let feelslikemin, precipcover: Double?
    let severerisk: Int?
    let description: String?
    let hours: [CurrentConditions]?
}

enum Conditions: String, Codable {
    case clear = "Clear"
    case overcast = "Overcast"
    case partiallyCloudy = "Partially cloudy"
    case rain = "Rain"
    case rainOvercast = "Rain, Overcast"
    case rainPartiallyCloudy = "Rain, Partially cloudy"
}

enum Icon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case rain = "rain"
}

enum Source: String, Codable {
    case comb = "comb"
    case fcst = "fcst"
    case obs = "obs"
}

enum ID: String, Codable {
    case remote = "remote"
    case vecc = "VECC"
}

// MARK: - Stations
struct Stations: Codable {
    let vecc: Vecc?

    enum CodingKeys: String, CodingKey {
        case vecc = "VECC"
    }
}

// MARK: - Vecc
struct Vecc: Codable {
    let distance: Int?
    let latitude, longitude: Double?
    let useCount: Int?
    let id, name: ID?
    let quality, contribution: Int?
}


