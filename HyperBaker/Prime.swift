//
//  Prime.swift
//  HyperBaker
//
//  Created by EMIdee66 on 6/30/15.
//  Copyright (c) 2015 EMIdee66. All rights reserved.
//

import Foundation
import RealmSwift

class Prime: NSObject {
    
    var name: String!
    var email: String!
    var token: String!
    
    init(name: String, email: String, token: String){
        self.name = name
        self.email = email
        self.token = token
    }

}


class PrimeObject: Object {
    
    dynamic var name = ""
    dynamic var email = ""
    
    convenience init(name: String, email: String) {
        self.init()
        self.name = name
        self.email = email
    }

}