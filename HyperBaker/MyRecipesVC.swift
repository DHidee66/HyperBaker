//
//  MyRecipesVC.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit
import DZNEmptyDataSet
import Alamofire
import SDWebImage
import MZFormSheetController
import BakerKit

class MyRecipesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var categoriesView: UIView!
    
    @IBAction func addRecipe(sender: UIBarButtonItem) {
        var newRecipeMZ = MZFormSheetController(size: CGSize(width: 345, height: 225), viewController: newRecipeVC)
        newRecipeMZ.transitionStyle = MZFormSheetTransitionStyle.SlideFromTop
        newRecipeMZ.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppears.MoveToTop
        newRecipeMZ.cornerRadius = 3.0
        newRecipeMZ.portraitTopInset = 150.0
        newRecipeMZ.shadowOpacity = 0.5
        newRecipeMZ.shouldDismissOnBackgroundViewTap = true
        newRecipeMZ.presentAnimated(true, completionHandler: nil)
    }
    
    @IBAction func showCategories(sender: UIBarButtonItem) {
      
    }
    
    var selectedRecipe: Recipe!
    var button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        setupLoadMore()
        updateDataSource()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
        self.tableView.reloadData()
    }
    
    //MARK: Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MyRecipeCell
        
        cell.recipe = recipeDataSource[indexPath.row]
        
        cell.imageV.sd_setImageWithURL(NSURL(string: recipeDataSource[indexPath.row].thumbnailURL ?? ""), placeholderImage: UIImage(named: "White")) { (image, error, cache, url) -> Void in
            cell.activityIndicator.stopAnimating()
        }
        
        if indexPath.row == recipeDataSource.count - 3 {
            tableView.tableFooterView = self.button
        }
        
        return cell
    }
    
    //MARK: Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRecipe = recipeDataSource[indexPath.row]
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! MyRecipeCell
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            request(.DELETE , recipesIdURL(recipeIDs[indexPath.row]), parameters: nil, encoding: ParameterEncoding.JSON).responseJSON(options: NSJSONReadingOptions.allZeros) { (request, response, object, error) -> Void in
            }
            
            recipeIDs.removeAtIndex(indexPath.row)
            recipeDataSource.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.reloadEmptyDataSet()
        } 
    }
    
    //MARK: Download Data
    
    func updateDataSource() {
        let tokenString = NSString(format: "Token token=%@", PrimeUser.token)
        
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": tokenString]
        
        request(.GET, recipesURL!, parameters: nil, encoding: ParameterEncoding.JSON).responseJSON(options: NSJSONReadingOptions.allZeros) { (_, response, objects, error) -> Void in
            
            if error == nil {
                for object in objects as! [NSDictionary] {
                    let recipe = Recipe(json: JSON(object))
                    if !(recipeIDs as NSArray).containsObject(recipe.id){
                        recipeDataSource.append(recipe)
                        recipeIDs.append(recipe.id)
                    }
                }
                
                self.tableView.reloadData()
                self.tableView.reloadEmptyDataSet()
            }
        }
    }
    
    //MARK: Empty Data Set
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "No recipes saved"
        var attributes = [NSFontAttributeName : UIFont.systemFontOfSize(19.0), NSForegroundColorAttributeName : UIColor.darkGrayColor()]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func emptyDataSetShouldDisplay(scrollView: UIScrollView!) -> Bool {
        
        if recipeDataSource.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "Empty")
    }
    
    //MARK: Segue Preparation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if let detailVC = segue.destinationViewController as? RecipeDetailVC where segue.identifier == "showDetail" {
                detailVC.recipe = selectedRecipe
            }
    }
    
    //MARK: Other
    
    private func setupLoadMore() {
        button.setTitle("Load More", forState: UIControlState.Normal)
        button.setTitleColor(Color.waveColor(), forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont.systemFontOfSize(15)
        button.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        button.backgroundColor = Color.clearColor()
        button.center = self.tableView!.center
        button.frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.frame.width, 40)
        button.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func refresh(sender: UIButton) {
        updateDataSource()
    }

}