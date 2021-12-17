//
//  ProfileHeader.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 9/21/21.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    
    //MARK: Properties
    
    private let profilefilter = ProfileFilterView()
        
    
        private lazy var topcontainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterblue
        
        
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 42) .isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16) .isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30) .isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30) .isActive = true
        
        return view
        }()
    
        private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp") .withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .purple
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.layer.borderColor = UIColor.twitterblue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterblue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleProfileFollow), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let fullNameLabel: UILabel = {
        let iv = UILabel()
        iv.text = "Khabib"
        iv.font = UIFont.boldSystemFont(ofSize: 20)
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let iv = UILabel()
        iv.text = "@HabibiKhabibi"
        iv.textColor = .lightGray
        iv.font = UIFont.systemFont(ofSize: 16)
        return iv
    }()
    
    
    
    private let biolabel: UILabel = {
        let iv = UILabel()
        iv.font = UIFont.systemFont(ofSize: 16)
        iv.numberOfLines = 3
        iv.text = "Khabib is the lightweight Champion with an undefeated record of 29-0"
        return iv
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterblue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    //MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerContainerViewUI()
        configureProfileUI()
        configureFollowButton()
        configureStackView()
        configureProfileFilter()
        configureUnderLineView()
        
        backgroundColor = .white
        
        profilefilter.delegate = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc func handleDismissal() {
        
    }
    
    @objc func handleProfileFollow() {
        
    }
    
    //MARK: Helpers
    
    func containerContainerViewUI() {
        addSubview(topcontainerView)
        topcontainerView.topAnchor.constraint(equalTo: topAnchor) .isActive = true
        topcontainerView.leftAnchor.constraint(equalTo: leftAnchor) .isActive = true
        topcontainerView.rightAnchor.constraint(equalTo: rightAnchor) .isActive = true
        topcontainerView.heightAnchor.constraint(equalToConstant: 108) .isActive = true
        topcontainerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configureProfileUI() {
        addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: topcontainerView.bottomAnchor, constant: -12) .isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8) .isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 80) .isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 80) .isActive = true
        profileImageView.layer.cornerRadius = 80 / 2
    }
    
    func configureFollowButton() {
        addSubview(editProfileFollowButton)
        editProfileFollowButton.topAnchor.constraint(equalTo: topcontainerView.bottomAnchor, constant: 12) .isActive = true
        editProfileFollowButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8) .isActive = true
        editProfileFollowButton.widthAnchor.constraint(equalToConstant: 100) .isActive = true
        editProfileFollowButton.heightAnchor.constraint(equalToConstant: 36) .isActive = true
        editProfileFollowButton.layer.cornerRadius = 36 / 2
    }
    
    func configureStackView() {
        let stackview = UIStackView(arrangedSubviews: [fullNameLabel, usernameLabel, biolabel])
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 4
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackview)
        stackview.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8) .isActive = true
        stackview.leftAnchor.constraint(equalTo: leftAnchor, constant: 12) .isActive = true
        stackview.rightAnchor.constraint(equalTo: rightAnchor, constant: 12).isActive = true
        
    }
    
    func configureProfileFilter() {
        profilefilter.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profilefilter)
        profilefilter.bottomAnchor.constraint(equalTo: bottomAnchor) .isActive = true
        profilefilter.rightAnchor.constraint(equalTo: rightAnchor) .isActive = true
        profilefilter.leftAnchor.constraint(equalTo: leftAnchor) .isActive = true
        profilefilter.heightAnchor.constraint(equalToConstant: 50) .isActive = true
    }
    
    func configureUnderLineView() {
        addSubview(underlineView)
        underlineView.leftAnchor.constraint(equalTo: leftAnchor) .isActive = true
        underlineView.bottomAnchor.constraint(equalTo: bottomAnchor) .isActive = true
        underlineView.widthAnchor.constraint(equalToConstant: frame.width / 3) .isActive = true
        underlineView.heightAnchor.constraint(equalToConstant: 2) .isActive = true
    }
    
}


extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionview.cellForItem(at: indexPath) as? ProfileFilterCell else {
            return }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
    
    
}
