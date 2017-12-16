//
//  ViewController.swift
//  AccountKitTest
//
//  Created by Raksmey on 12/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import AccountKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}
class ViewController: UIViewController {
    var accountkit: AKFAccountKit!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var phoneOrEmailLabel: UILabel!
    @IBOutlet weak var accountIDLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        print("accountkit is nil")
        if accountkit == nil{
            print("account kit is nil")
            self.accountkit = AKFAccountKit(responseType: .accessToken)
            self.accountkit.requestAccount({ (account, error) in
                self.accountIDLabel.text = account?.accountID
                if account?.emailAddress?.characters.count > 0  {
                    //if the user is logged with email
                    self.typeLabel.text = "Email Address"
                    self.phoneOrEmailLabel.text = account!.emailAddress
                    
                }
                else if account?.phoneNumber?.phoneNumber != nil {
                    //if the user is logged with phone
                    self.typeLabel.text = "Phone Number"
                    self.phoneOrEmailLabel.text = account!.phoneNumber?.stringRepresentation()
                }
                
            })
        }
    }

 
    @IBAction func logoutButton(_ sender: Any) {
        //You can invoke the logOut method to log a user out of Account Kit.
        accountkit.logOut()
        dismiss(animated: true, completion: nil)
    }
    
}

