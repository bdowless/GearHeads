//
//  FeedController.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 6/12/21.
//

import UIKit
import SDWebImage
import Firebase

private let reuseIdentifier = "RevCell"

class FeedController: UICollectionViewController {
    
    private var revs = [Rev]() {
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
        fetchRevs()
    }
    
    // MARK: API
    
    func fetchRevs() {
        RevService.shared.fetchTweets { revs in
            self.revs = revs
        }
    }
    
    //MARK: Helpers
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        } catch let error {
            print("DEBUG: FAiled to sign out with error \(error.localizedDescription)")
        }
    }
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(RevCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let iconImage = UIImageView(image: UIImage(named: "gearheads-logo"))
        iconImage.contentMode = .scaleAspectFit
        iconImage.heightAnchor.constraint(equalToConstant: 44) .isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 44) .isActive = true
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = iconImage
        
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        profileImageView.widthAnchor.constraint(equalToConstant: 32) .isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32) .isActive = true
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    func configureLeftBarButton() {
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
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
        return revs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RevCell
        cell.rev = revs[indexPath.row]
        
        // setting the delegate property in the cell
        // self refers to this view controller (FeedController)
        // this establishes the relationship via the protocol between delegate and controller
        // when the cell calls the fucntion via the delegate, the code that is in the view controller gets executed
        cell.delegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rev = revs[indexPath.row]
        let controller = RevDetailController(rev: rev)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

// MARK: - TweetCellDelegate

extension FeedController: TweetCellDelegate {
    func handleFetchUser(withUsername username: String) {
        UserService.shared.fetchUser(uid: username) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func handleLikeTapped(_ cell: RevCell) {
        guard let rev = cell.rev else { return }
        
        RevService.shared.likeTweet(tweet: rev) { (err, ref) in
            cell.rev?.didLike.toggle()
            let likes = rev.didLike ? rev.likes - 1 : rev.likes + 1
            cell.rev?.likes = likes
            
            // only upload notification if tweet is being liked
            guard !rev.didLike else { return }
            let uid = rev.user.uid
            NotificationService.uploadNotification(type: .like, toUid: uid)
        }
    }
    
    func handleReplyTapped(_ cell: RevCell) {
        guard let rev = cell.rev else { return }
        let controller = UploadTweetController(user: rev.user, config: .reply(rev))
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func handleProfileImageTapped(_ cell: RevCell) {
        guard let user = cell.rev?.user else { return }
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}
