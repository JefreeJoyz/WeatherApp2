//
//  MainPageView.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 08.06.2022.
//

import SwiftUI
import Foundation

struct MainPageView: View {
    
    var body: some View {
        ZStack {
            VStack {
                WeatherNow()
                ForecastPerHour()
                ForecastPerEachDay()
//                ForEach(apiViewModel.weatherForecast) { data in
//                    Text(data.cod!)
//                }
            }
        }
        //.ignoresSafeArea() - blocks NavigationLink
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}

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
                                VStack {
//                                    Text("\(vm.unixTimeConvert(unixTime: elements.time))")
//                                        .onTapGesture {
//                                            print((vm.timeTo(time: elements.time)))
//                                        }
                                    Text("\(elements.time)")
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
                            }
                        }
                    }
                    .frame(width: 100, height: 120)
                }
            }
        }
    }
}


struct ForecastPerEachDay: View {
    @StateObject var vm = WeatherViewModel()
    var body: some View {
        List {
            ForEach(vm.forecastFiveDays) { items in
                ForEach(items.forecast.forecastday) { key in
                    HStack {
                        Text("\(key.date)")
                        Spacer()
                        Text("\(Int(key.day.maxtempC))° / \(Int(key.day.mintempC))°")
                        Spacer()
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

struct WeatherNow: View {
    @StateObject var vm = WeatherViewModel()
    var body: some View {
        
        ZStack {
            Color(.init(srgbRed: 0.29, green: 0.56, blue: 0.89, alpha: 1))
            VStack(alignment: .leading) {
                ForEach(vm.currentWeather) { temperature in
                VStack {
                    // top line: city
                    HStack {
                        Image(systemName: "location.fill")
                        NavigationLink("Запорожье") {
                            LocationView()
                        }
                        Spacer()
                        Image(systemName: "circle.square")
                    }
                    .padding(.top)
                    .font(.largeTitle)
                    Text("Чт, 19 июля")
                }
                HStack {
                    // Weather image
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
                    VStack(alignment: .leading) {
                            Image(systemName: "thermometer")
                            Image(systemName: "humidity")
                            Image(systemName: "wind")
                        }
                    // temperature values
                    VStack(alignment: .leading) {
                        Text("\(Int(temperature.current.tempC.rounded()))°")
                        Text("\(Int(temperature.current.humidity))%")
                        Text("\(Int(temperature.current.windKph)) km / h")
                    }
                    }
                }
                .padding(.trailing, 20)
                .font(.headline)
            }
            .foregroundColor(.white)
            .padding(.top)
            .padding(.horizontal)
        }
    }
}
