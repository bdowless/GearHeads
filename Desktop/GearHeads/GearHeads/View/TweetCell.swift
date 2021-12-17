//
//  TweetCell.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 9/9/21.
//

import UIKit

// declaration of protocol
protocol tweetCellDelegate: class {
    // required functions that are part of protocol.
    // any class that conforms to protocol has to implement these functions
    func handleProfileImageTapped()
}

class TweetCell: UICollectionViewCell {
    
    // delegate property
    // data type of delegate is cast to the protocol that we created
    // this gives us access to the functions that we need to call in the cell that are part of the protocol
    weak var delegate: tweetCellDelegate?
    
    var tweet: Tweet? {
        didSet{configureTweet()}
    }
    //MARK Properties
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.heightAnchor.constraint(equalToConstant: 48) .isActive = true
        iv.widthAnchor.constraint(equalToConstant: 48) .isActive = true
        iv.layer.cornerRadius = 48 / 2
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .twitterblue
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleprofileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
//    private let profileImageViewss: UIImageView = {
//        let iv = imageView(image: <#T##UIImage#>, height: <#T##CGFloat#>, width: <#T##CGFloat#>)
//        return iv
//    }()
//    
    
    
    private let Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "This is a Test Label"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let iv = UILabel()
        iv.text = "Khabib is the GOAT"
        iv.font = UIFont.systemFont(ofSize: 14)
        return iv
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.heightAnchor.constraint(equalToConstant: 20) .isActive = true
        button.widthAnchor.constraint(equalToConstant: 20) .isActive = true
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.heightAnchor.constraint(equalToConstant: 20) .isActive = true
        button.widthAnchor.constraint(equalToConstant: 20) .isActive = true
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        button.tintColor = .darkGray
        button.heightAnchor.constraint(equalToConstant: 20) .isActive = true
        button.widthAnchor.constraint(equalToConstant: 20) .isActive = true
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.tintColor = .darkGray
        button.heightAnchor.constraint(equalToConstant: 20) .isActive = true
        button.widthAnchor.constraint(equalToConstant: 20) .isActive = true
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors
    
    @objc func handleprofileImageTapped() {
//        // this is where we call the protocol function
//        // the actual code that gets executed is in the class that conforms to the protocol
//        // this would be the feed controller
////        guard let tweet = self.tweet else { return }
        delegate?.handleProfileImageTapped()

        
        
        print("DEBUG: profile image tapped")
    }
    
    @objc func handleCommentTapped() {
        
    }
    
    @objc func handleRetweetTapped() {
        
    }
    
    @objc func handleLikeTapped() {
        
    }
    
    @objc func handleShareTapped() {
        
    }
    
    // MARK: Helpers
    
    func configureUI() {
        
        addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8) .isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8) .isActive = true
        
        let stack = UIStackView(arrangedSubviews: [Label, infoLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
    
        
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: profileImageView.topAnchor) .isActive = true
        stack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10) .isActive = true
        stack.centerXAnchor.constraint(equalTo: centerXAnchor) .isActive = true

        
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        actionStack.spacing = 72
        
        addSubview(actionStack)
        actionStack.centerXAnchor.constraint(equalTo: centerXAnchor) .isActive = true
        actionStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8) .isActive = true
    }
    
    

    
    func configureTweet(){
        guard let tweet = tweet else { return }
        
        let tweetModel = TweetViewModel(tweet: tweet)
        
        print("DEBUG: tweet user is \(tweet.user.username)")
        
        profileImageView.sd_setImage(with: tweetModel.profileImageURl, completed: nil)
        
        Label.attributedText = tweetModel.userInfoText
        
        
    }
}
