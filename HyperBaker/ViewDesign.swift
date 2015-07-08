//
//  ViewDesign.swift
//  HyperBaker
//
//  Created by EMIdee66 on 7/2/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit
import BakerKit

class RoundedTextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = Color.waveColor().CGColor
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.0
    }
}
