//
//  RecipeDetailVC.swift
//  HyperBaker
//
//  Created by EMIdee66 on 7/1/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import Alamofire
import BakerKit

class RecipeDetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var instructionTV: UITextView!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var scrollView: TPKeyboardAvoidingScrollView!
    
    @IBAction func back() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func edit() {
        if editable {
            editButton.image = UIImage(named: "Edit")
            instructionTV.editable = false
            descriptionTF.editable = false
            editable = false
            
            let parameters: [String : AnyObject] = ["recipe" : [ "instructions" : instructionTV.text, "description" : descriptionTF.text, "favorite" : favorite]]
            
            request(.PUT, recipesIdURL(recipe.id), parameters: parameters, encoding: ParameterEncoding.JSON).responseJSON(options: NSJSONReadingOptions.allZeros) { (request, response, object, error) -> Void in
                
                if error != nil {
                    JLToast.makeText("No Connection. Please try again later.", duration: JLToastDelay.LongDelay).show()
                }
            }
            
        } else {
            editButton.image = UIImage(named: "Save")
            instructionTV.editable = true
            descriptionTF.editable = true
            editable = true
        }
    }
    
    @IBAction func favouriteAction() {
        if favorite {
            favouriteButton.setImage(UIImage(named: "Star"), forState: UIControlState.Normal)
            recipeDataSource[index].favourite = false
            favorite = false
        } else {
            favouriteButton.setImage(UIImage(named: "StarS"), forState: UIControlState.Normal)
            recipeDataSource[index].favourite = true
            favorite = true
        }
    }
    
    var recipe: Recipe! {
        didSet {
            index = (recipeDataSource as NSArray).indexOfObject(recipe)
        }
    }
    var manager = SDWebImageManager.sharedManager()
    var index: Int!
    
    var editable = false
    var favorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JLToastView.setDefaultValue(20, forAttributeName: JLToastViewPortraitOffsetYAttributeName, userInterfaceIdiom: UIUserInterfaceIdiom.Phone)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.progressView.hidden = false
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 685)
        
        updateViewData()
    }
    
    func updateViewData() {
        self.navigationItem.title = recipe.title
        self.favorite = recipe.favourite ?? false
        
        SDWebImageDownloader.sharedDownloader().downloadImageWithURL(NSURL(string: recipe.imageURL ?? "")!, options: SDWebImageDownloaderOptions.ProgressiveDownload, progress: { (received, expected) -> Void in
            
            self.progressView.progress = Float(received/expected)
            
            }) { (image, data, error, finished) -> Void in
                
                if error == nil {
                    self.imageView.image = image
                }
                
                if finished {
                    self.progressView.hidden = true
                }
        }
        
        instructionTV.text = recipe.instructions
        difficulty.text = convertDifficultyLevel(recipe.difficultyLevel)
        createdDate.text = recipe.createdDate
        descriptionTF.text = recipe.descriptions
        favouriteButton.setImage({
            return self.favorite ? UIImage(named: "StarS") : UIImage(named: "Star")
            }(), forState: UIControlState.Normal)
    }
}