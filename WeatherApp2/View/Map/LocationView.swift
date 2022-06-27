//
//  LocationView.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject var vm: LocationManager
    @EnvironmentObject var vmv: WeatherViewModel
    
    var body: some View {
        ZStack {
            
            Map(coordinateRegion: $vm.region,
                showsUserLocation: true,
                annotationItems: vm.localCities,
                annotationContent: { item in
                MapAnnotation(coordinate: item.coordinates) {
                    LocationMapAnnotationView()
                        .onTapGesture {
                            // Обновляем наш mapLocation - выбранный город
                            vm.showLocation(location: item)
                            
                            // Обновляем погоду
                            vmv.dataService.getCurrentWeather2(
                                lat: String(item.coordinates.latitude),
                                lon: String(item.coordinates.longitude))
                            vmv.forecastService.getForecastFiveDays(
                                lat: String(item.coordinates.latitude),
                                lon: String(item.coordinates.longitude))
                        }
                }
            })
            .ignoresSafeArea()
            
            VStack {
                Button {
                    vm.showLocationList.toggle()
                } label: {
                    Text("\(vm.mapLocation.cityName)")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)
                        .font(.headline)
                        .background(.white)
                        .cornerRadius(15)
                }
                if vm.showLocationList {
                    CitiesListView()
                }
                Spacer()
            }
            .padding()
        }
        .onAppear {
            vm.checkIfLocationServivesIsEnabled()
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(dev.homeVM)
            .environmentObject(dev.homeVML)
    }
}
