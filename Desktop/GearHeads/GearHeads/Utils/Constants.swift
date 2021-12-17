//
//  Constants.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 8/2/21.
//

import Firebase


let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let DB_TWEETS = DB_REF.child("tweets")
