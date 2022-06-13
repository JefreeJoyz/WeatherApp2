//
//  CitiesListView.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 10.06.2022.
//

import SwiftUI

struct CitiesListView: View {
    
    @EnvironmentObject var vm : LocationManager
    @EnvironmentObject var vmv : WeatherViewModel
    
    var body: some View {
        List {
            ForEach(vm.localCities) { items in
                // По клику на элемент - отправляем координаты города в функции получения прогноза на сейчас и на ближайшие дни
                Button {
                    vm.showLocation(location: items)
                    vmv.getCurrentWeather2(lat: "\(String(describing: vm.locationManager?.location?.coordinate.latitude))", lon: "\(String(describing: vm.locationManager?.location?.coordinate.longitude))")
                    vmv.getForecastFiveDays(lat: "\(String(describing: vm.locationManager?.location?.coordinate.latitude))", lon: "\(String(describing: vm.locationManager?.location?.coordinate.longitude))")
                } label: {
                    Text("\(items.cityName)")
                }

                
            }
            .padding(.vertical, 4)
            .listRowBackground(Color.clear)
        }
    }
}

struct CitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesListView()
    }
}
