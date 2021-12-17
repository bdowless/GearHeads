//
//  NotificationsService.swift
//  GearHeads
//
//  Created by Stephen Dowless on 12/17/21.
//

import Firebase


struct NotificationService {
    
    func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        var notifications = [Notification]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        REF_NOTIFICATIONS.child(currentUid).observeSingleEvent(of: .value) { snapshot in
            let notificationId = snapshot.key
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.forEach { snapshot in
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                
                let notification = Notification(notificationID: notificationId, dictionary: dictionary)
                notifications.append(notification)
                
            }
            
            completion(notifications)
        }
    }
    
    static func uploadNotification(type: NotificationType, toUid uid: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let values = ["type": type.rawValue, "uid": currentUid, "timestamp": Int(NSDate().timeIntervalSince1970)] as [String : Any]
        REF_NOTIFICATIONS.child(uid).childByAutoId().updateChildValues(values)
    }
}
