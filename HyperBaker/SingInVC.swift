//
//  SingInVC.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import MZFormSheetController
import KeychainAccess

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInButton: LogButton!
    
    @IBAction func logIn(sender: UIButton) {
        (self.view as! LogView).changeIndicatorStatus(false, title: "")
        checkCredentials()
    }
    
    @IBAction func recoverPassword() {
      presentMZFormSheet(CGSize(width: 250, height: 155),recoverVC)
    }
    
    let users = Realm().objects(PrimeObject)
    
    // Helper Methods
    
    func checkCredentials() {
        
        let password = keychain["password"]
        let token = keychain["token"]
        
        for user in users {
            if user.email == emailTF.text && password == passwordTF.text {
                PrimeUser = Prime(name: user.name, email: user.email, token: token!)
                self.performSegueWithIdentifier("signIn", sender: self)
            }
        }
        (self.view as! LogView).changeIndicatorStatus(false, title: "Sign In")
    }
        
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}