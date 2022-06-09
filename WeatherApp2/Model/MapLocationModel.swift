//
//  MapLocationModel.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import Foundation
import MapKit

struct MapLocation: Identifiable {
    var id: UUID? = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
}
