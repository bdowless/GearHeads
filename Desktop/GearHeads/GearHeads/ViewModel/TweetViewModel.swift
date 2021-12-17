//
//  TweetViewModel.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 9/17/21.
//

import UIKit

struct TweetViewModel {
    
    let tweet: Tweet
    let user: User
    
    
    var profileImageURl: URL? {
        return tweet.user.profileImageUrl
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: tweet.user.username,attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: " @\(user.fullname)",
                                        attributes: [.font:UIFont.systemFont(ofSize: 14),
                                                     .foregroundColor: UIColor.lightGray]))
        
        return title
        
    }

    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
