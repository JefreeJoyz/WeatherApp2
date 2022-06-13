//
//  CurrentWeatherView.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import SwiftUI

struct WeatherNow: View {
    
    @EnvironmentObject var vm: WeatherViewModel
    @EnvironmentObject var vmv: LocationManager
    
    var body: some View {
        ZStack {
            Color(.init(srgbRed: 0.29, green: 0.56, blue: 0.89, alpha: 1))
            VStack(alignment: .leading) {
                ForEach(vm.currentWeather) { temperature in
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "location.fill")
                            Text("\(vmv.mapLocation.cityName)")
                            Spacer()
                            NavigationLink {
                                LocationView()
                            } label: {
                                Image(systemName: "map.fill")
                            }
                        }
                        .padding(.top)
                        .font(.largeTitle)
                        Text("\(vm.unixTimeToWed(unixTime: temperature.location.localtimeEpoch, timeformat: timeFormat.shortData.rawValue))")
                    }
                    HStack {
                        // Тянем картинку
                        AsyncImage(url: URL(string: "https:\(temperature.current.condition.icon)")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let returnedImage):
                                returnedImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            case .failure:
                                Image(systemName: "questionmark")
                            @unknown default:
                                Text("unknown case")
                            }
                        }
                        Spacer()
                        // pictograms
                        VStack(alignment: .leading, spacing: 5) {
                            Image(systemName: "thermometer")
                            Image(systemName: "humidity")
                            Image(systemName: "wind")
                        }
                        // temperature values
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(Int(temperature.current.tempC.rounded()))°")
                            Text("\(Int(temperature.current.humidity))%")
                            Text("\(Int(temperature.current.windKph)) km / h")
                        }
                    }
                    .font(.title2)
                }
                .padding(.trailing, 20)
                .font(.headline)
            }
            .foregroundColor(.white)
            .padding(.top)
            .padding(.horizontal)
        }
        .frame(height: 300)
    }
}

struct WeatherNow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNow()
    }
}
