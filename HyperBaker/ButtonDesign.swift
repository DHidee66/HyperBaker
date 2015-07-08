//
//  ButtonDesign.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit
import BakerKit

class LogButton: UIButton {
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = Color.watermelonColor().CGColor
        self.layer.cornerRadius = 0.0
        self.layer.borderWidth = 1.0
    }
    
}

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 3.0
    }
}

class ColorfulButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = self.titleColorForState(UIControlState.Normal)?.CGColor
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.0
    }
}
