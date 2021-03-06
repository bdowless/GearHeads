//
//  TweetService.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 8/18/21.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0,
                      "caption": caption] as [String : Any]
        

        DB_TWEETS.childByAutoId().updateChildValues(values,withCompletionBlock: completion)
        }
    
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        DB_TWEETS.observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            let tweetID = snapshot.key
            guard let uid = dictionary ["uid"] as? String else { return }
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
                
            
           
    }
        
    }
    

}


