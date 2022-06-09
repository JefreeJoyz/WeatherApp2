//
//  ForecastPerHourView.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import SwiftUI

struct ForecastPerHour: View {
    @StateObject var vm = WeatherViewModel()
    var body: some View {
        ZStack {
            Color(.init(srgbRed: 0.35, green: 0.62, blue: 0.94, alpha: 1))
            ScrollView(.horizontal) {
                HStack {
                    ForEach(vm.forecastFiveDays) { items in
                        ForEach(items.forecast.forecastday) { keys in
                            ForEach(keys.hour) { elements in
                                VStack(spacing: 0) {
                                    Text("\(vm.unixTimeConvert(unixTime: elements.timeEpoch))")
                                    AsyncImage(url: URL(string: "https:\(keys.day.condition.icon)")) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let returnedImage):
                                            returnedImage
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                        case .failure:
                                            Image(systemName: "questionmark")
                                        @unknown default:
                                            Text("unknown case")
                                        }
                                    }
                                    Text("\(Int(elements.tempC))°")
                                }
                                .font(.headline)
                            }
                        }
                    }
                    .frame(width: 90, height: 100)
                }
                //.background(Color.red)
            }
            
            .foregroundColor(.white)
            .frame(height: 50)
        }
        .frame(height: 150)
    }
}

struct ForecastPerHour_Previews: PreviewProvider {
    static var previews: some View {
        ForecastPerHour()
    }
}
