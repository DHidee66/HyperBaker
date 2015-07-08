//
//  LogView.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit

class LogView: UIView {
    
    @IBOutlet weak var logButton: LogButton!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var activityIV = UIActivityIndicatorView()
        activityIV.frame.size = CGSize(width: 20, height: 20)
        activityIV.center = self.logButton.center
        activityIV.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIV.color = Color.watermelonColor()
        activityIV.hidesWhenStopped = true
        return activityIV
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(activityIndicator)
    }
    
    func changeIndicatorStatus(start: Bool, title: String?) {
        if start {
            logButton.setTitle("", forState: UIControlState.Normal)
            logButton.userInteractionEnabled = false
            self.userInteractionEnabled = false
            activityIndicator.startAnimating()
        } else {
            logButton.setTitle(title!, forState: UIControlState.Normal)
            logButton.userInteractionEnabled = true
            self.userInteractionEnabled = true
            activityIndicator.stopAnimating()
        }
    }
    
}