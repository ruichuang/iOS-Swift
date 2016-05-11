//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rui on 2016-03-25.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {
    
    var weatherService = WeatherService()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descrptionLbl: UILabel!
    
    
    @IBOutlet weak var cloudsLbl: UILabel!
    //@IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var setCity: UIButton!
    @IBOutlet weak var iconImage: UIImageView!

    
    
    @IBAction func setCityTapped(sender: UIButton) {
        openCityAlert()
        }
    
    func openCityAlert() {
        //ceate alert controller
        let alert = UIAlertController(title: "City", message: "Enter City Name", preferredStyle: UIAlertControllerStyle.Alert)
        //add cancel btn
        let cancel = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel, handler: nil)
        
        //add OK btn
        let ok = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                
                let textField = alert.textFields?[0]
                let cityName = textField?.text!
                //self.cityLbl.text = cityName
                self.weatherService.getWeatherForCity(cityName!)
                
        }
        //add action to controller
        alert.addAction(cancel)
        alert.addAction(ok)
        
        //add text field
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "City Name"
        }
        
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: weather service delegate
    
    func setWeather(weather: Weather) {
        
        let c = weather.temp - 273.15
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.maximumFractionDigits = 1
        let Celsius = formatter.stringFromNumber(c)!
        
        tempLabel.text = "\(Celsius)℃"
        descrptionLbl.text = weather.description
        setCity.setTitle(weather.cityName, forState: UIControlState.Normal)
        iconImage.image = UIImage(named: weather.icon)
        cloudsLbl.text = "Clouds: \(weather.clouds)%"
    }
    
    func weatherErrorWithMessage(message: String) {
        let alter = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alter.addAction(ok)
        
        self.presentViewController(alter, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherService.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

