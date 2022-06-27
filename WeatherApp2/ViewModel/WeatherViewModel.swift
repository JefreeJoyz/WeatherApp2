//
//  WeatherViewModel.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import Foundation
import Combine



class WeatherViewModel: ObservableObject {
    
    @Published var currentWeather: [Current] = []
    @Published var forecastFiveDays: [Forecast] = []
    
    let dataService = WeatherDataService()
    let forecastService = WeatherForecast()
    var cancellables = Set<AnyCancellable> ()
    
    
  
    init () {
        addSubscribers ()
    }
    
    func addSubscribers () {
        dataService.$currentWeather
            .sink { [weak self] returnedWeather in
                self?.currentWeather = returnedWeather
            }
            .store(in: &cancellables)
        
        forecastService.$forecastFiveDays
            .sink { [weak self] returnedForecast in
                self?.forecastFiveDays = returnedForecast
            }
            .store(in: &cancellables)
    }

    
    // Конвертер времени
    func unixTimeToWed (unixTime: Int, timeformat: String) -> String {
        
        let unixTimestamp = Double(unixTime)
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EEST")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = timeformat
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
}

enum timeFormat: String {
    case Wednesday = "E"
    case shortData = "E, MMM dd"
    case hoursDays = "HH:mm"
}
