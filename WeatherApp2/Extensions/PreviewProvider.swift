//
//  PreviewProvider.swift
//  WeatherApp2
//
//  Created by Eugene Yakushev on 20.06.2022.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    // Каждый раз, когда мы инициализируем PreviewProvider - мы получаем инстанс DeveloperPreview
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    private init () { }
    
    let homeVM = WeatherViewModel()
    let homeVML = LocationManager()
}
