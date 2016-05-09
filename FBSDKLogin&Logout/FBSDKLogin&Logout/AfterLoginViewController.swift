//
//  AfterLoginViewController.swift
//  FBSDKLogin&Logout
//
//  Created by Rui on 2016-05-08.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class AfterLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutFromFB(sender: UIButton) {
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        let loginPageNav = UINavigationController(rootViewController: loginPage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginPageNav
        
    }

   

}
