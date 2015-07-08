//
//  SignUpVC.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift
import KeychainAccess

class SignUpVC: UIViewController {
    
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpButton: LogButton!
    
    @IBAction func signUp(sender: UIButton) {
        
        (self.view as! LogView).changeIndicatorStatus(true, title: nil)
        self.view.endEditing(true)
        
        let parameters: [String : AnyObject] = ["user" : ["email" : emailTF.text, "password" : passwordTF.text, "password_confirmation" : passwordTF.text, "seed_recipes" : true]]
        
        request(.POST, usersURL!, parameters: parameters, encoding: ParameterEncoding.JSON).responseJSON(options: NSJSONReadingOptions.allZeros) { (request, response, object, error) -> Void in
            
            (self.view as! LogView).changeIndicatorStatus(false, title: "Sign Up")
            
            if !(response!.description as NSString).containsString("status code: 400") {
                
                let token = (object as! NSDictionary)["auth_token"] as! String
                
                keychain["token"] = token
                keychain["password"] = self.passwordTF.text
                
                let primeObject = PrimeObject(name: self.fullNameTF.text, email: self.emailTF.text)
                
                PrimeUser = Prime(name: self.fullNameTF.text, email: self.emailTF.text, token: token)
                
                realm.write({ () -> Void in
                    realm.add(primeObject)
                })
                
                self.performSegueWithIdentifier("signUp", sender: self)
            }
        }
    }
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    // Delegate Methods
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}