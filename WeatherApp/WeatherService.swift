//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Rui on 2016-03-26.
//  Copyright © 2016 Rui. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate{
    func setWeather(weather: Weather)
    func weatherErrorWithMessage(message: String)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func getWeatherForCity(city: String){
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let appid = "ed3d911734342ee4b9e0ecd748e77562"
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=\(appid)"
        
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?,
            response: NSURLResponse?, error: NSError?) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            let json = JSON(data: data!)
            
            var status = 0
            
            if let cod = json["cod"].int {
                status = cod
            }else if let cod = json["cod"].string{
                status = Int(cod)!
            }
            
            print("Weather status code: \(status)")
            if status == 200{
                
                //let lon = json["coord"]["lon"].double
                //let lat = json["coord"]["lat"].double
                let temp = json["main"]["temp"].double
                let name = json["name"].string
                let desc = json["weather"][0]["description"].string
                let icon = json["weather"][0]["icon"].string
                let clouds = json["clouds"]["all"].double
                
                let weather = Weather(
                    cityName: name!,
                    description: desc!, temp: temp!,
                    icon: icon!,clouds: clouds!
                )
                
                
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.setWeather(weather)
                    })
                }
                
            } else if status == 404 {
                
                if self.delegate != nil {
                    // back to main thread
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.weatherErrorWithMessage("City not found")
                    })
                }
                
            } else {
                
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.weatherErrorWithMessage("Some error")
                    })
                }
            }
        }
        
        task.resume()
    }
}






