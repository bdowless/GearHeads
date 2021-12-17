//
//  ProfileFilterCell.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 9/30/21.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    //MARK: Properties
    
    var option: ProfileFitlerOptions! {
        didSet{tweetLabel.text = option.description}
    }
    
    var tweetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .twitterblue
        label.text = "Tweet"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            tweetLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) :
            UIFont.systemFont(ofSize: 14)
            tweetLabel.textColor = isSelected ? .twitterblue : .lightGray
        }
    }
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        ConfigureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ConfigureCell() {
        addSubview(tweetLabel)
        tweetLabel.centerXAnchor.constraint(equalTo: centerXAnchor) .isActive = true
        tweetLabel.centerYAnchor.constraint(equalTo: centerYAnchor) .isActive = true
    }
}

