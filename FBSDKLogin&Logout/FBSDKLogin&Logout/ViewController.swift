//
//  ViewController.swift
//  FBSDKLogin&Logout
//
//  Created by Rui on 2016-05-08.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

//no view needed -1
//    let loginBtn: FBSDKLoginButton = {
//        let button = FBSDKLoginButton()
//        button.readPermissions = ["public_profile", "email", "user_friends"]
//        return button
//    }
    
    
    // put the login btn in a view
    @IBOutlet weak var fbLoginBtn: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fbLoginBtn.delegate = self
        fbLoginBtn.readPermissions = ["public_profile", "email", "user_friends"]
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            fetchFile()
        }
//no view needed -2
//        view.addSubview(loginBtn)
//        loginBtn.center = self.view.center
//        loginBtn.delegate = self
    }
    
    func fetchFile(){
        let parameters = ["fields": "email, first_name, last_name"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            if let email = result["email"] as? String {
                print(email)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            
            let afterLoginPage = self.storyboard?.instantiateViewControllerWithIdentifier("AfterLoginViewController") as! AfterLoginViewController
            let afterLoginPageNav = UINavigationController(rootViewController: afterLoginPage)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = afterLoginPageNav

        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        
        if error != nil {
            print(error.localizedDescription)
            return
        }
        
        if result.token != nil {
            // get access token
            let token: FBSDKAccessToken = result.token
            print("Token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("ID = \(FBSDKAccessToken.currentAccessToken().userID)")
            
            let afterLoginPage = self.storyboard?.instantiateViewControllerWithIdentifier("AfterLoginViewController") as! AfterLoginViewController
            let afterLoginPageNav = UINavigationController(rootViewController: afterLoginPage)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = afterLoginPageNav
            
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        print("user log out")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

