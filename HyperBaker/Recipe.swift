//
//  Recipe.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import UIKit
import BakerKit

class Recipe: NSObject {
    
    var id: Int!
    var title: String!
    var descriptions: String?
    var updatedDate: String!
    var createdDate: String!
    var difficultyLevel: Int!
    var image: UIImage?
    var imageURL: String?
    var thumbnailURL: String?
    var favourite: Bool?
    var userID: Int!
    var instructions: String?
    
    init(json: JSON) {
        super.init()
        
        parseObject(json)
    }
    
    func parseObject(json: JSON) {
        
        self.id = json["id"].int
        self.title = json["name"].string
        self.descriptions = json["description"].string
        self.updatedDate = convertDate(json["updated_at"].string!)
        self.createdDate = convertDate(json["created_at"].string!)
        self.imageURL = json["photo"]["url"].string
        self.thumbnailURL = json["photo"]["thumbnail_url"].string
        self.favourite = json["favorite"].bool ?? false
        self.difficultyLevel = json["difficulty"].int
        self.userID = json["user_id"].int
        self.instructions = json["instructions"].string
    }
    
    func convertDate(date: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.dateFromString(date) {
            var mydateFormatter = NSDateFormatter()
            mydateFormatter.dateFormat = "dd/MM' at 'HH:mm"
            return mydateFormatter.stringFromDate(date)
        }
        return ""
    }
}
