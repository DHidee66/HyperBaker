//
//  GlobalConstants.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import KeychainAccess
import RealmSwift

// Backend

let usersURL = NSURL(string: "http://hyper-recipes.herokuapp.com/users")
let recipesURL = NSURL(string: "http://hyper-recipes.herokuapp.com/recipes")

func recipesIdURL(id: Int) -> NSURL {
    return NSURL(string: "http://hyper-recipes.herokuapp.com/recipes/\(id)")!
}

// View Controller

let storyboard = UIStoryboard(name: "Main", bundle: nil)
let newRecipeVC = storyboard.instantiateViewControllerWithIdentifier("AddRecipeVC") as! AddRecipeVC
let recoverVC = storyboard.instantiateViewControllerWithIdentifier("RecoverVC") as! RecoverVC

// Instances

var PrimeUser: Prime!
var recipeDataSource: [Recipe]! = []
var recipeIDs = [Int]()
let realm = Realm()

// Functions

func delay(#seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

func convertDifficultyLevel(level: Int) -> String {
    switch level {
    case 1:
        return NSLocalizedString("easy", comment: "easy recipe difficulty")
    case 2:
        return NSLocalizedString("normal", comment: "normal recipe difficulty")
    case 3:
        return NSLocalizedString("hard", comment: "hard recipe difficulty")
    default: break
    }
    return ""
}

// Other

let cell0 = NSIndexPath(forRow: 0, inSection: 0)
let sortCategories = ["Favourite", "A-Z", "Z-A", "Recent"]
let keychain = Keychain(service: "com.hyperbaker.secret")