//
//  WeatherApp2App.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 08.06.2022.
//

import SwiftUI

@main
struct WeatherApp2App: App {
    @StateObject private var vm = LocationViewModel()
    @StateObject private var vwm = WeatherViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainPageView()
                    
            }
            .environmentObject(vm)
            .environmentObject(vwm)
            .onAppear {
                vm.locationService.checkIfLocationServivesIsEnabled()
                }
            .navigationViewStyle(.stack)
        }
    }
}
