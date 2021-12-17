//
//  ProfileHeaderViewModel.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 10/6/21.
//

import Foundation


enum ProfileFitlerOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    
    var description: String {
        switch self {
        case.tweets: return "Tweets"
        case.replies: return "Tweets & Replies"
        case.likes: return "Likes"
        }
    }
    
}
