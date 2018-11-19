//
//  User.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import SwiftyJSON

open class User: Jsonable {
    var id: Int = 0
    var name: String = ""
    
    //Optional property
    var password: String = ""
    
    public required init?(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}

