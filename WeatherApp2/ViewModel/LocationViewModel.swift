//
//  LocationViewModel.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import MapKit
import SwiftUI

class LocationManager: NSObject,CLLocationManagerDelegate, ObservableObject { // CLLocationManagerDelegate - уведомляет нас каждый раз
    
    override init () {
        let localCities = LocationsData.cities
        self.localCities = localCities
        self.mapLocation = localCities.first!
    }
    var locationManager: CLLocationManager? // Optional, ибо юзер может выключить свою геолокацию
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.8388, longitude: 35.1396),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)) // center - координата, span - зум
    
    @Published var localCities: [MyCity]
    
    // Инициация locationManager
    func checkIfLocationServivesIsEnabled () {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager ()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            //checkLocationAuthorization () - если пропишем так, то оно запросит пермишен только в 1й раз. А потом если юзер ограничит их - оно спрашивать не будет
            locationManager?.delegate = self
        } else {
            print ("locationServices isn't Enabled")
        }
    }
    
    // Получаем координаты юзера
    var userLatitude: String {
            return "\(locationManager?.location?.coordinate.latitude ?? 0)"
        }
    var userLongitude: String {
            return "\(locationManager?.location?.coordinate.longitude ?? 0)"
        }
    
    // Проверяем наличие пермишенов
    private func checkLocationAuthorization () {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
            
        case .notDetermined: // пермишены не запрошены
            locationManager.requestWhenInUseAuthorization()
        case .restricted: // запрещено, обычно родителями
            print("check your parent control")
        case .denied: // забрали пермишены
            print("go into settings and turn it on")
        case .authorizedAlways, .authorizedWhenInUse:
            // если пермишены предоставлены - я центрирую карту на реальную локацию через locationManager.location?.coordinate
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)) // force-unwrap делать нельзя, позже переделать
        @unknown default:
            break
        }
    }
    // Система дергает этот метод каждый раз, как только мы создаем locationManager и повторно, если изменились доступы аппа (пермишены)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization ()
    }
    
    // Показать лист городов
    @Published var showLocationList: Bool = false
    
    
    func showLocation(location: MyCity) {
        mapLocation = location
        showLocationList = false
    }
    
    // Нужна для того, что бы дернуть функцию
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
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
    }
}
