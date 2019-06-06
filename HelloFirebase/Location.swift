//
//  Location.swift
//  HelloFirebase
//
//  Created by alunor17 on 06/06/2019.
//  Copyright © 2019 Daniel Valente. All rights reserved.
//

import UIKit
import Firebase

class Location {
    var location:String
    var members:Int
    var isFull:Bool
    var ref: DatabaseReference?
    
    init(location:String, members:Int, isFull:Bool, ref:DatabaseReference?) {
        self.location = location
        self.members = members
        self.isFull = isFull
        self.ref = ref
    }
    
    func toAnyObject() -> Any {
        return ["location":location, "members":members, "isFull":isFull]
    }
}
