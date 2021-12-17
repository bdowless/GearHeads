//
//  UserService.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 8/6/21.
//

import Firebase
import FirebaseDatabase


struct UserService {
    static let shared = UserService()

    func fetchUser(uid: String, completion: @escaping(User) -> Void) {

        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            print("DEBUG:\(snapshot)")
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }

                let user = User(uid: uid, dictionary: dictionary)
                completion(user)
        }
    }
    
        
    func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        REF_USERS.observeSingleEvent(of: .value) { snapshot in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.forEach { snapshot in
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                let uid = snapshot.key
                let user = User(uid: uid, dictionary: dictionary)
                users.append(user)
                completion(users)
            }
        }
    }
}
 

 
