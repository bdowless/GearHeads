//
//  NotificationsController.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 6/12/21.
//

import UIKit

class NotificationsController: UITableViewController {

    //MARK: Properties
    
    var notifications = [Notification]()
    let service = NotificationService()
    
    //MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchNotifications()
    }
    
    //MARK: Helpers
    
    func configureUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
    }
}

// MARK: - API

extension NotificationsController {
    func fetchNotifications() {
        service.fetchNotifications { notifications in
            self.notifications = notifications
            self.tableView.reloadData()
        }
    }
}

extension NotificationsController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = notifications[indexPath.row].type.notificationMessage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
}
