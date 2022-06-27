//
//  LocationViewModel.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import MapKit
import SwiftUI

class LocationViewModel: NSObject,CLLocationManagerDelegate, ObservableObject { // CLLocationManagerDelegate - уведомляет нас каждый раз
    
    // Показать лист городов
    @Published var showLocationList: Bool = false
    @Published var localCities: [MyCity]
    
    let locationService = LocationManager()
    
    
    func showLocation(location: MyCity) {
        mapLocation = location
        showLocationList = false
    }
    
    // Выбранный город
    @Published var mapLocation: MyCity {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Обновление локации при выбранном городе
    func updateMapRegion (location: MyCity) {
        withAnimation(.easeInOut) {
            region = MKCoordinateRegion(
                center: location.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 12.0, longitudeDelta: 12.0))
        }
    }
    
    // Получаем координаты юзера
    var userLatitude: String {
        return "\(locationService.locationManager?.location?.coordinate.latitude ?? 0)"
        }
    var userLongitude: String {
        return "\(locationService.locationManager?.location?.coordinate.longitude ?? 0)"
        }
    
    override init () {
        let localCities = LocationsData.cities
        self.localCities = localCities
        self.mapLocation = localCities.first!
    }
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.8388, longitude: 35.1396),
        span: MKCoordinateSpan(latitudeDelta: 12.0, longitudeDelta: 12.0))
    
}
