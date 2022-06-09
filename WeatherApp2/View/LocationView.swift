//
//  LocationView.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @StateObject var vm = LocationManager()
    
    var body: some View {
        Map(coordinateRegion: $vm.region,
        showsUserLocation: true)
            .ignoresSafeArea()
            .onAppear {
                vm.checkIfLocationServivesIsEnabled()
            }
        //Text("\(vm.userLatitude)")
        //Text("\(vm.userLongitude)")
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
