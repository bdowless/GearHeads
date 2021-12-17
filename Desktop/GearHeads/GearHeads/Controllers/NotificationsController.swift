//
//  NotificationsController.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 6/12/21.
//

import UIKit

class NotificationsController: UIViewController {

    //MARK: Properties
    
    //MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
    }
}