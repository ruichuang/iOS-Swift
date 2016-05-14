//
//  Models.swift
//  MockAppStore
//
//  Created by Rui on 2016-05-12.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "apps" {
            
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeysWithDictionary(dict)
                apps?.append(app)
            }
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fatchFeaturedApps(competionHandler: ([AppCategory]) -> ()){
        
        let urlString = "http://www.statsallday.com/appstore/featured"
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            
            do {
                let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                
                
                var appCategories = [AppCategory]()
                
                for dict in json["categories"] as! [[String: AnyObject]] {
                    let appCategory = AppCategory()
                    appCategory.setValuesForKeysWithDictionary(dict)
                    appCategories.append(appCategory)
                }
                
                dispatch_async(dispatch_get_main_queue(), { 
                    competionHandler(appCategories)
                })
            } catch let errr {
                print(errr)
            }
            
        }.resume()
    }
    
    static func sampleAppCategories() -> [AppCategory]{
        
        let newGamesWeLoveCategory = AppCategory()
        newGamesWeLoveCategory.name = "New Games We Love"
        
        var apps = [App]()
        
        let clashApp = App()
        clashApp.name = "Clash of Clans"
        clashApp.imageName = "clash"
        clashApp.category = "Game"
        clashApp.price = NSNumber(float: 5.99)
    
        apps.append(clashApp)
        newGamesWeLoveCategory.apps = apps
        
        let newAppsWeLoveCategory = AppCategory()
        newAppsWeLoveCategory.name = "New Apps We Love"
        
        var newAppsWeLoveApps = [App]()
        
        let weatherApp = App()
        weatherApp.name = "Weather"
        weatherApp.category = "Utility"
        weatherApp.imageName = "weather"
        weatherApp.price = NSNumber(float: 0.99)
        
        newAppsWeLoveApps.append(weatherApp)
        newAppsWeLoveCategory.apps = newAppsWeLoveApps
        
        return [newGamesWeLoveCategory, newAppsWeLoveCategory]
    }
}

class App: NSObject {
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
}
