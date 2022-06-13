//
//  MainPageView.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 08.06.2022.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var vm: WeatherViewModel

    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                WeatherNow()
                ForecastPerHour()
                ForecastPerEachDay()
                Spacer()
            }
        }
        .navigationTitle("Main")
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}



