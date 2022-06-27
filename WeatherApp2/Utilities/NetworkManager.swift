//
//  NetworkManager.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 27.06.2022.
//

import Foundation
import Combine

let key: String = "9f3b3debc4ac4497aa9205218220806"
let baseUrl: String = "https://api.weatherapi.com/v1/"

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[💩] Bad response from URL. \(url)"
                case .unknown: return "[🔥] unknown error occured"
            }
        }
    }
    
//    static func download(url: URL) -> AnyPublisher<Data, Error> {
//       //let temp = - что бы посмотреть, какой тип надо вернуть, присваиваем переменной URLSession и option+click по переменной
//        // после этого - добавляем .eraseToAnyPublisher() и копируем из ошибки требуемый возвращаемый тип
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .default))
//            .tryMap({ try handleUrlResponse(output: $0, url: url) })
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
    
    static func handleUrlResponse (output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription )
        }
    }
    
    // Валидация хттп респонсов
    static func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
