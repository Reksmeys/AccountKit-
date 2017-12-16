//
//  LoginViewController.swift
//  AccountKitTest
//
//  Created by Raksmey on 12/16/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import AccountKit

class LoginViewController: UIViewController, AKFViewControllerDelegate {
    var accounkit: AKFAccountKit!
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize accountkit
        if accounkit == nil {
            //may specific AKFRresponseType
            self.accounkit = AKFAccountKit(responseType: AKFResponseType.accessToken)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if accounkit.currentAccessToken != nil{
            //if user already logged in go to home page
            print("user have already login")
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "showHome", sender: self)
            })
        }
    }
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("login success with account kit")
    }
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("login successs with authentication")
    }
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didFailWithError error: Error!) {
        print(" login with accountkit failed:\(error)")
    }
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)!) {
        print("user cancel login")
    }
    
    
    func prepareLoginViewController(_ loginViewController: AKFViewController) {
        
        loginViewController.delegate = self
        loginViewController.setAdvancedUIManager(nil)
        
        //Costumize the theme for login account kit
        let theme:AKFTheme = AKFTheme.default()
        theme.headerBackgroundColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.headerTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
        theme.statusBarStyle = .default
        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        loginViewController.setTheme(theme)
        
        loginViewController.defaultCountryCode = "KH";
    
    }
    
   
    @IBAction func loginWithEmail(_ sender: Any) {
        //login with email
        let inputState:String = UUID().uuidString
        let viewController: AKFViewController = accounkit.viewControllerForEmailLogin(withEmail: nil, state: inputState)  as! AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareLoginViewController(viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func loginWithPhone(_ sender: Any) {
        //login with phone
        let inputState:String = UUID().uuidString
        let viewController: AKFViewController = accounkit.viewControllerForPhoneLogin(with: nil, state: inputState)  as! AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareLoginViewController(viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
