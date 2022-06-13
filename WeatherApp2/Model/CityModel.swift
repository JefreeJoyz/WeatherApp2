//
//  CityModel.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 10.06.2022.
//

import Foundation
import MapKit

struct MyCity: Identifiable {
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    var id: String {
        name + cityName
    }
}
