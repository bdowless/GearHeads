//
//  FeedController.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 6/12/21.
//

import UIKit
import SDWebImage
import Firebase

private let reuseIdentifier = "tweetCell"

class FeedController: UICollectionViewController {
     
    private var tweets = [Tweet]() {
        didSet{(collectionView.reloadData())}
    }

    //MARK: Properties
    
    var user: User
    
    //MARK: LifeCycle

    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLeftBarButton()
        fetchTweets()
    }
    
    // MARK: API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
    }
    
    //MARK: Helpers
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            present(controller, animated: true, completion: nil)
        } catch let error {
            print("DEBUG: FAiled to sign out with error \(error.localizedDescription)")
        }
    }
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let twitterimage = UIImageView(image: #imageLiteral(resourceName: "twitter_logo_blue"))
        twitterimage.contentMode = .scaleAspectFit
        twitterimage.heightAnchor.constraint(equalToConstant: 44) .isActive = true
        twitterimage.widthAnchor.constraint(equalToConstant: 44) .isActive = true
        twitterimage.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = twitterimage
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterblue
        profileImageView.widthAnchor.constraint(equalToConstant: 32) .isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32) .isActive = true
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    func configureLeftBarButton() {
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterblue
        profileImageView.widthAnchor.constraint(equalToConstant: 32) .isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32) .isActive = true
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        // setting the delegate property in the cell
        // self refers to this view controller (FeedController)
        // this establishes the relationship via the protocol between delegate and controller
        // when the cell calls the fucntion via the delegate, the code that is in the view controller gets executed
        cell.delegate = self
        return cell
    }
    

    
    }

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

// view controller conforms to protocol and implements functions that are part of protocol
extension FeedController: tweetCellDelegate {
    func handleProfileImageTapped() {
        print("DEBUG: ACTION TAPPED in the collectionViewController")
        // when function gets called in cell, the code that gets executed happens here
        let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(controller, animated: true)
    }
}
