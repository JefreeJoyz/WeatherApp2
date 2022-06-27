//
//  WeatherDataService.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 27.06.2022.
//

import Foundation
import Combine

class WeatherDataService {
    
    @Published var currentWeather: [Current] = []
    var weatherSubscription: AnyCancellable?
    
    init () {
        getCurrentWeather2 (lat: "47.8388", lon: "35.1396")
    }
    
    // Получаем прогноз на сегодня
    func getCurrentWeather2 (lat: String, lon: String) {
        guard let url = URL(string: "\(baseUrl)current.json?key=\(key)&q=\(lat),\(lon)&aqi=no") else { return }
        
        weatherSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap({ try NetworkingManager.handleOutput(output: $0) })
            .decode(type: Current.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedPosts in
                
                self?.currentWeather = []
                self?.currentWeather.append(returnedPosts)
                self?.weatherSubscription?.cancel()
            })
    }
}
