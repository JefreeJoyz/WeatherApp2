//
//  LocationsData.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 10.06.2022.
//

import Foundation
import MapKit

// Имитация JSON

class LocationsData {
    
    static let cities: [MyCity] = [
        MyCity(
            name: "Zaporizha",
            cityName: "Запорожье",
            coordinates: CLLocationCoordinate2D(latitude: 47.8388, longitude: 35.1396),
            description: ""),

        MyCity(
            name: "Kyiv",
            cityName: "Киев",
            coordinates: CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234),
            description: ""),
        
        MyCity(
            name: "Odesa",
            cityName: "Одеса",
            coordinates: CLLocationCoordinate2D(latitude: 46.4825, longitude: 30.7233),
            description: ""),
    ]
}
