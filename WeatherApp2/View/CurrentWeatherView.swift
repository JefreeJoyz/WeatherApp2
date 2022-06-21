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
            logic
            .foregroundColor(.white)
            .padding(.top)
            .padding(.horizontal)
        }
        .ignoresSafeArea()
        //.frame(height: 300)
    }
}

struct WeatherNow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNow()
            .environmentObject(dev.homeVM)
            .environmentObject(dev.homeVML)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}


extension WeatherNow {
    private var logic: some View {
        VStack(alignment: .leading) {
            ForEach(vm.currentWeather) { temperature in
                // хедер + дата
                VStack (alignment: .leading) {
                    // Хедер
                    HStack {
                        Image(systemName: "location.fill")
                            .onTapGesture {
                                vm.getCurrentWeather2(lat: vmv.userLatitude, lon: vmv.userLongitude)
                                vm.getForecastFiveDays(lat: vmv.userLatitude, lon: vmv.userLongitude)
                            }
                        // Выбранный город
                        Text("\(temperature.location.name)")
                            .lineLimit(1)
                        Spacer()
                        // Навигация по клику по картинке
                        NavigationLink {
                            LocationView()
                        } label: {
                            Image(systemName: "map.fill")
                        }
                    }
                    .font(.largeTitle)
                    // Отображаем текущую дату
                    Text("\(vm.unixTimeToWed(unixTime: temperature.location.localtimeEpoch, timeformat: timeFormat.shortData.rawValue))")
                }
                .padding(.top) 
                // Значек погоды, пиктограммы и их значения
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
                                .frame(width: 150, height: 150)
                        case .failure:
                            Image(systemName: "questionmark")
                        @unknown default:
                            Text("unknown case")
                        }
                    }
                    
                    Spacer()
                    // Пиктограммы
                    VStack(alignment: .leading, spacing: 5) {
                        Image(systemName: "thermometer")
                        Image(systemName: "humidity")
                        Image(systemName: "wind")
                    }
                    // Значения пиктограмм
                    VStack(alignment: .leading, spacing: 5) {
                        // Текущая температура
                        Text("\(Int(temperature.current.tempC.rounded()))°")
                        // Влажность
                        Text("\(Int(temperature.current.humidity))%")
                        // Скорость ветра
                        Text("\(Int(temperature.current.windKph)) km / h")
                    }
                }
                .font(.title2)
                .padding(.top)
            }
            .padding(.trailing, 20)
            .font(.headline)
        }
        .padding(.top)
    }
}
