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
            coordinates: CLLocationCoordinate2D(latitude: 47.84, longitude: 35.14),
            description: ""),

        MyCity(
            name: "Kyiv",
            cityName: "Киев",
            coordinates: CLLocationCoordinate2D(latitude: 50.46, longitude: 30.54),
            description: ""),
        
        MyCity(
            name: "Odesa",
            cityName: "Одеса",
            coordinates: CLLocationCoordinate2D(latitude: 46.47, longitude: 30.73),
            description: ""),
    ]
}
