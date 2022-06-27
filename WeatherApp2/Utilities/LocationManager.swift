//
//  LocationManager.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 27.06.2022.
//

import MapKit

class LocationManager: NSObject,CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager? // Optional, ибо юзер может выключить свою геолокацию
    
    // Инициация locationManager
    func checkIfLocationServivesIsEnabled () {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager ()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
        } else {
            print ("locationServices isn't Enabled")
        }
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
            break
        @unknown default:
            break
        }
    }
    // Система дергает этот метод каждый раз, как только мы создаем locationManager и повторно, если изменились доступы аппа (пермишены)
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization ()
    }
}
