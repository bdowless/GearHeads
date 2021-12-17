//
//  TweetService.swift
//  TwitterTutorial
//
//  Created by Stephen Dowless on 1/28/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Firebase

struct RevService {
    static let shared = RevService()
    
    func uploadTweet(caption: String, type: UploadTweetConfiguration, completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = [KEY_CAPTION: caption,
                      KEY_TIMESTAMP: Int(NSDate().timeIntervalSince1970),
                      KEY_LIKES: 0,
                      KEY_UID: uid,
                      KEY_RETWEET_COUNT: 0] as [String : Any]
                
        switch type {
        case .reply(let tweet):
            REF_REVS_REPLIES.child(tweet.revID).childByAutoId().updateChildValues(values) { (err, ref) in
                guard let replyKey = ref.key else { return }
                REF_USER_REPLIES.child(uid).updateChildValues([tweet.revID: replyKey], withCompletionBlock: completion)
            }
        case .tweet:
            REF_REVS.childByAutoId().updateChildValues(values) { (err, ref) in
                guard let key = ref.key else { return }
                REF_USER_REVS.child(uid).updateChildValues([key: 1], withCompletionBlock: completion)
            }
        }
    }
    
    func fetchTweets(completion: @escaping([Rev]) -> Void) {
        var tweets = [Rev]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        REF_USER_FOLLOWING.child(currentUid).observe(.childAdded) { snapshot in
            let followingUid = snapshot.key

            REF_USER_REVS.child(followingUid).observe(.childAdded) { snapshot in
                let revID = snapshot.key

                self.fetchTweet(withrevID: revID) { tweet in
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }

        REF_USER_REVS.child(currentUid).observe(.childAdded) { snapshot in
            let revID = snapshot.key

            self.fetchTweet(withrevID: revID) { tweet in
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func fetchTweets(withUid uid: String, completion: @escaping([Rev]) -> Void) {
        var tweets = [Rev]()
        
        REF_USER_REVS.child(uid).observe(.childAdded) { snapshot in
            self.fetchTweet(withrevID: snapshot.key) { tweet in
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func fetchTweet(withrevID revID: String, completion: @escaping(Rev) -> Void) {
        REF_REVS.child(revID).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Rev(user: user, revID: revID, dictionary: dictionary)
                completion(tweet)
            }
        }
    }
    
    func fetchReplies(forUser user: User, completion: @escaping([Rev]) -> Void) {
        var replies = [Rev]()
        
        REF_USER_REPLIES.child(user.uid).observe(.childAdded) { snapshot in
            let tweetKey = snapshot.key
            guard let replyKey = snapshot.value as? String else { return }
            
            REF_REVS_REPLIES.child(tweetKey).child(replyKey).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                guard let uid = dictionary["uid"] as? String else { return }
                let replyID = snapshot.key
                
                UserService.shared.fetchUser(uid: uid) { user in
                    let reply = Rev(user: user, revID: replyID, dictionary: dictionary)
                    replies.append(reply)
                    completion(replies)
                }
            }
        }
    }
    
    func fetchReplies(forTweet tweet: Rev, completion: @escaping([Rev]) -> Void) {
        var tweets = [Rev]()
        
        REF_REVS_REPLIES.child(tweet.revID).observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let revID = snapshot.key
                        
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Rev(user: user, revID: revID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func fetchLikes(forUser user: User, completion: @escaping([Rev]) -> Void) {
        var tweets = [Rev]()
        
        REF_USER_LIKES.child(user.uid).observe(.childAdded) { snapshot in
            let revID = snapshot.key
            self.fetchTweet(withrevID: revID) { likedTweet in
                var tweet = likedTweet
                tweet.didLike = true
                
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func likeTweet(tweet: Rev, completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
        REF_REVS.child(tweet.revID).child("likes").setValue(likes)
        
        if tweet.didLike {
            // unlike tweet
            REF_USER_LIKES.child(uid).child(tweet.revID).removeValue { (err, ref) in
                REF_REV_LIKES.child(tweet.revID).removeValue(completionBlock: completion)
            }
        } else {
            // like tweet
            REF_USER_LIKES.child(uid).updateChildValues([tweet.revID: 1]) { (err, ref) in
                REF_REV_LIKES.child(tweet.revID).updateChildValues([uid: 1], withCompletionBlock: completion)
            }
        }
    }
    
    func checkIfUserLikedTweet(_ tweet: Rev, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_LIKES.child(uid).child(tweet.revID).observeSingleEvent(of: .value) { snapshot in
            completion(snapshot.exists())
        }
    }
}
