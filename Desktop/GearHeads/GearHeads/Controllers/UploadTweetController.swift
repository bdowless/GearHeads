//
//  UploadTweetController.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 8/9/21.
//

import UIKit

class uploadTweetController: UIViewController {
    
    //MARK: - Properties
    
    private let user: User
    
    private lazy var tweetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .twitterblue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.heightAnchor.constraint(equalToConstant: 48) .isActive = true
        iv.widthAnchor.constraint(equalToConstant: 48) .isActive = true
        iv.layer.cornerRadius = 48 / 2
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .twitterblue
        return iv
    }()
    
    private let captionTextView = CaptionTextView()
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfileImageView()
        configureUI()
        
        
        
    }
    
    //MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        
        TweetService.shared.uploadTweet(caption: caption) { (error, red) in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
    
    func configureProfileImageView() {
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        stack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16) .isActive = true
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 16) .isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor) .isActive = true
        
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
    }
    
}
