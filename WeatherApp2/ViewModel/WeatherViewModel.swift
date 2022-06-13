//
//  WeatherViewModel.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import Foundation
import Combine

let key: String = "9f3b3debc4ac4497aa9205218220806"
let baseUrl: String = "https://api.weatherapi.com/v1/"

class WeatherViewModel: ObservableObject {
    
    @Published var currentWeather: [Current] = []
    @Published var forecastFiveDays: [Forecast] = []
    var cancellables = Set<AnyCancellable> ()
    
    
  
    init () {
        getForecastFiveDays (lat: "47.8388", lon: "35.1396")
        getCurrentWeather2  (lat: "47.8388", lon: "35.1396")
    }
    
    func getCurrentWeather2 (lat: String, lon: String) {
        guard let url = URL(string: "\(baseUrl)current.json?key=\(key)&q=\(lat),\(lon)&aqi=no") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: Current.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                    print("lat: \(lat), lon: \(lon)")
                case .failure(let error):
                    print("There was an error in getCurrentWeather. \(error) ")
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.currentWeather = []
                self?.currentWeather.append(returnedPosts)
                
            }
            .store(in: &cancellables)
    }
    
    
    
    func getForecastFiveDays (lat: String, lon: String) {
        guard let url = URL(string: "\(baseUrl)forecast.json?key=\(key)&q=\(lat),\(lon)&days=5&aqi=no&alerts=no") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: Forecast.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("There was an error in getForecastFiveDays. \(error) ")
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.forecastFiveDays = []
                self?.forecastFiveDays.append(returnedPosts)
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
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
