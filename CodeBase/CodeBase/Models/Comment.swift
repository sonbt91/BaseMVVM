//
//  Comment.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import SwiftyJSON

open class Comment: Jsonable {
    
    public var postId = 0
    public var id = 0
    public var name = ""
    public var email = ""
    public var body = ""
    
    required public init?(json: JSON) {
        self.postId = json["postId"].intValue
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.email = json["email"].stringValue
        self.body = json["body"].stringValue
    }
}

