//
//  MyRecipeCell.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit
import BakerKit

class MyRecipeCell: UITableViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favouriteView: UIView!
    
    var recipe: Recipe! {
        didSet {
            self.titleLabel.text = recipe.title
            self.descriptionLabel.text = recipe.descriptions
            self.dateLabel.text = recipe.updatedDate
                        
            self.favouriteView.backgroundColor = {
                return self.recipe.favourite! ? Color.buttermilkColor() : Color.whiteColor()
            }()
            
            self.difficultyLabel.text = convertDifficultyLevel(recipe.difficultyLevel)
        }
    }
}
