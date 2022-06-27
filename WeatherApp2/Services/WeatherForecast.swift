//
//  WeatherForecast.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 27.06.2022.
//

import Foundation
import Combine

class WeatherForecast {
    
    @Published var forecastFiveDays: [Forecast] = []
    var forecastSubscription: AnyCancellable?
    
    init () {
        getForecastFiveDays (lat: "47.8388", lon: "35.1396")
    }
    
    // Получаем прогноз погоды
    func getForecastFiveDays (lat: String, lon: String) {
        guard let url = URL(string: "\(baseUrl)forecast.json?key=\(key)&q=\(lat),\(lon)&days=5&aqi=no&alerts=no") else { return }
        
        forecastSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap({ try NetworkingManager.handleOutput(output: $0) })
            .decode(type: Forecast.self, decoder: JSONDecoder())
            .sink ( receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedPosts) in
                self?.forecastFiveDays = []
                self?.forecastFiveDays.append(returnedPosts)
                self?.forecastSubscription?.cancel()
            })
    }
}
