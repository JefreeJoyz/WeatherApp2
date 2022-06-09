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
    var cancellables = Set<AnyCancellable> ()
    
    
    init () {
        getCurrentWeather ()
        getForecastFiveDays ()
        //timeConvert (unixTime: 1)
    }
    
    func getCurrentWeather () {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=9f3b3debc4ac4497aa9205218220806&q=134.249.4.247&aqi=no") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: Current.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("There was an error in getCurrentWeather. \(error) ")
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.currentWeather.append(returnedPosts)
                
            }
            .store(in: &cancellables)
    }
    
    func getForecastFiveDays () {
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=9f3b3debc4ac4497aa9205218220806&q=134.249.4.247&days=5&aqi=no&alerts=no") else { return }
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
    
    func unixTimeConvert (unixTime: Int) -> String {
        
        let unixTimestamp = Double(unixTime)
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
        
    }
    
//    func timeTo (time: String) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        
//        let newFormatter = DateFormatter()
//        newFormatter.dateFormat = "HH:mm"
//        
//        let date = formatter.date(from: time)
//        print(date as Any)
//        return date
//    }
}
