//
//  MainPageView.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 08.06.2022.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var vm: WeatherViewModel
    @EnvironmentObject var vmv: LocationViewModel

    var body: some View {
        ZStack {
            ScrollView {
                VStack (spacing: 0) {
                    WeatherNow()
                    .ignoresSafeArea()
                    .frame(maxHeight: 350)
                    ForecastPerHour()
                    ForecastPerEachDay()
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .navigationTitle("Main")
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vmv.locationService.checkIfLocationServivesIsEnabled()
        }

    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
            .previewDevice("iPhone 13")
            .environmentObject(dev.homeVM)
            .environmentObject(dev.homeVML)
            .previewInterfaceOrientation(.portrait)
    }
}



