//
//  Weather.swift
//  WeatherApp
//
//  Created by Rui on 2016-03-26.
//  Copyright © 2016 Rui. All rights reserved.
//

import Foundation

struct Weather {
    let cityName: String
    let description: String
    let temp: Double
    let icon: String
    let clouds: Double
    
    init(cityName: String, description: String,
        temp: Double, icon: String,
        clouds: Double){
        self.cityName = cityName
        self.description = description
        self.temp = temp
        self.icon = icon
        self.clouds = clouds
    }
}
