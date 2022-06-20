//
//  ForecastPerDayView.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 09.06.2022.
//

import SwiftUI

struct ForecastPerEachDay: View {
    
    @EnvironmentObject var vm: WeatherViewModel
    
    var body: some View {
        List {
            ForEach(vm.forecastFiveDays) { items in
                ForEach(items.forecast.forecastday) { key in
                    HStack {
                        // юникс дату конвертим в человеческую
                        Text("\(vm.unixTimeToWed(unixTime: key.dateEpoch, timeformat: timeFormat.Wednesday.rawValue))")
                            .frame(width: 50)
                            .offset(x: -10)
                        Spacer()
                        // макс и мин температура
                            Text("\(Int(key.day.maxtempC))° / \(Int(key.day.mintempC))°")
                            .frame(width: 100)
                        Spacer()
                        // Тянем картинку погоды
                        AsyncImage(url: URL(string: "https:\(key.day.condition.icon)")) { phase in
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
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct ForecastPerEachDay_Previews: PreviewProvider {
    static var previews: some View {
        ForecastPerEachDay()
            .environmentObject(dev.homeVM)
    }
}
