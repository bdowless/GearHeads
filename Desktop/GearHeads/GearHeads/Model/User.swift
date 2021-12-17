//
//  User.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 8/6/21.
//

import Foundation

struct User {
    let email: String
    let username: String
    let fullname: String
    let password: String
    var profileImageUrl: URL?
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fulname"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}
