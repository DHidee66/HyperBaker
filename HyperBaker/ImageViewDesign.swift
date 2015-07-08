//
//  ImageViewDesign.swift
//  HyperBaker
//
//  Created by EMIdee66 on 7/1/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit

class RecipeImageView: UIImageView {
    
    // MARK: Internals views
    var button : UIButton = UIButton(frame: CGRectZero)
    
    required init(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: views setup
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.userInteractionEnabled = true
        self.button.frame = self.bounds
        self.addSubview(self.button)
    }
}