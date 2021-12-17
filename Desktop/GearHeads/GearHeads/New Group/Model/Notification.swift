//
//  Notification.swift
//  GearHeads
//
//  Created by Stephen Dowless on 12/17/21.
//

import Firebase

struct Notification {
    let uid: String
    let notificationID: String
    let timestamp: Int
    let type: NotificationType
    
    init(notificationID: String, dictionary: [String: AnyObject]) {
        self.notificationID = notificationID
        
        self.timestamp = dictionary["timestamp"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type) ?? .like
        } else {
            self.type = .like
        }
    }
    
}

enum NotificationType: Int {
    case like
    case follow
    case reply
    
    var notificationMessage: String {
        switch self {
        case .like:
            return " liked one of your revs"
        case .follow:
            return " started following you"
        case .reply:
            return " replied to one of your revs"
        }
    }
}
