//
//  AddRecipeVC.swift
//  HyperBaker
//
//  Created by EMIdee66 on 7/1/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking
import BakerKit

class AddRecipeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var instructionTV: UITextView!
    @IBOutlet weak var imageView: RecipeImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func difficultySC(sender: UISegmentedControl) {
        selectedDifficulty = sender.selectedSegmentIndex
    }
    
    @IBAction func saveAction(sender: UIButton) {
     
     if titleTF.text != "" {
        let parameters: [String : AnyObject] = ["recipe" : ["name" : titleTF.text, "difficulty" : selectedDifficulty + 1, "description" : descriptionTF.text, "instructions" : instructionTV.text,"favorite" : favourite]]
        
        let manager = AFHTTPRequestOperationManager()
        
        let tokenString = String(format: "Token token=%@", PrimeUser.token)
        
        manager.requestSerializer.setValue(tokenString, forHTTPHeaderField: "Authorization")
        
        manager.POST("http://hyper-recipes.herokuapp.com/recipes", parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
            
            if let imageData = self.imageJPGRepresentation {
                formData.appendPartWithFileData(imageData, name: "recipe[photo]", fileName: "\(self.titleTF.text)image", mimeType: "image/jpeg")
            }
            
        }, success: { (operation, responseObj) -> Void in
            JLToast.makeText("√ Succesfully posted", duration: JLToastDelay.ShortDelay).show()
        }) { (operation, error) -> Void in
            JLToast.makeText("√ No Connection. Please try again later.", duration: JLToastDelay.LongDelay).show()
        }
        
        cleanData()
      }
    }
    
    var selectedDifficulty: Int! = 0
    var favourite = false
    
    var imageJPGRepresentation: NSData?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
    }
    
    // Image Picker Controller
    
    func presentIP(sender: UIButton) {
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        UIGraphicsBeginImageContext(CGSizeMake(60, 60))
        image.drawInRect(CGRectMake(0, 0, 60, 60))
        
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.imageView.image = smallImage
                
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
            self.imageJPGRepresentation = UIImageJPEGRepresentation(image, 0.2)
            
            var stringImage = self.imageJPGRepresentation!.base64EncodedStringWithOptions( NSDataBase64EncodingOptions.allZeros)
        })
    }
    
    // Text Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == titleTF {
            descriptionTF.becomeFirstResponder()
            titleTF.resignFirstResponder()
        } else if textField == descriptionTF {
            instructionTV.becomeFirstResponder()
            descriptionTF.resignFirstResponder()
        }
        return true
    }
    
    // Clean Data
    
    func cleanData() {
        titleTF.text = ""
        descriptionTF.text = ""
        instructionTV.text = ""
        imageView.image = UIImage(named: "Pic")
        segmentedControl.selectedSegmentIndex = -1
        self.mz_dismissFormSheetControllerAnimated(true, completionHandler: nil)
    }
    
    // Other
    
    func setupVC() {
        self.imageView.button.addTarget(self, action: "presentIP:", forControlEvents: UIControlEvents.TouchUpInside)
        
        JLToastView.setDefaultValue(20, forAttributeName: JLToastViewPortraitOffsetYAttributeName, userInterfaceIdiom: UIUserInterfaceIdiom.Phone)
        
        titleTF.returnKeyType = UIReturnKeyType.Next
        descriptionTF.returnKeyType = UIReturnKeyType.Next
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    }
}