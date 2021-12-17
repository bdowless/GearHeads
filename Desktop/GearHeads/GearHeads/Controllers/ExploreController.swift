//
//  ExploreController.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 6/12/21.
//

import UIKit

class ExploreController: UITableViewController {

    //MARK: Properties
    
    private let reuseIdentifier = "Cell"
    
    private var users = [User]()
    
    //MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    //MARK: API
    
    func fetchUsers() {
        UserService.shared.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: Helpers
    
    func configureUI() {
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .red
        navigationItem.title = "Explore"
    }
}

extension ExploreController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text = users[indexPath.row].username
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }      
}
