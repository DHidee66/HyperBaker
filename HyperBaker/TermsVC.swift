//
//  TermsVC.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit

class TermsVC: UIViewController {
    
    @IBOutlet weak var termsTextView: UITextView!
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    let termsResource = NSBundle.mainBundle().pathForResource("Terms", ofType: "txt")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var terms = NSString(contentsOfFile: termsResource!, encoding: NSUTF8StringEncoding, error: nil)
        termsTextView.text = String(terms!)
    }
}