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
    
    var body: some View {
        ZStack {
            
            Map(coordinateRegion: $vm.region,
                showsUserLocation: true,
                annotationItems: vm.localCities,
                annotationContent: { location in
                // Flags on the map
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                    //LocationMapAnnotationView()
                    // vm.MapLocation == location - if our location is current
                        .onTapGesture {
                            vm.showLocation(location: location)
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
    }
}
