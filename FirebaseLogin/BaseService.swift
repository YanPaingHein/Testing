//
//  BaseService.swift
//  FirebaseLogin
//
//  Created by Nu Wai Thu on 3/11/16.
//  Copyright © 2016 Nu Wai Thu. All rights reserved.
//

import Foundation
import Firebase


let BASE_URL = "https://mobilenu.firebaseio.com/"

let FIREBASE_REF = Firebase(url: BASE_URL)

var CURRENT_USER: Firebase
{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    
    let currentUser = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    
    return currentUser!
}
