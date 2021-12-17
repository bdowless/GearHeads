//
//  ImageView.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 9/27/21.
//

import UIKit


func imageView(image: UIImage, height: CGFloat, width: CGFloat) -> UIImageView {
    let image = image
    let height = height
    let width = width
    
    let iv = UIImageView()
    iv.image = image
    iv.clipsToBounds = true
    iv.heightAnchor.constraint(equalToConstant: height) .isActive = true
    iv.widthAnchor.constraint(equalToConstant: width) .isActive = true
    iv.layer.cornerRadius = 48 / 2
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.backgroundColor = .twitterblue
    iv.isUserInteractionEnabled = true
        return iv
    }



//private lazy var profileImageView: UIImageView = {
//    let iv = UIImageView()
//    iv.contentMode = .scaleAspectFit
//    iv.clipsToBounds = true
//    iv.heightAnchor.constraint(equalToConstant: 48) .isActive = true
//    iv.widthAnchor.constraint(equalToConstant: 48) .isActive = true
//    iv.layer.cornerRadius = 48 / 2
//    iv.translatesAutoresizingMaskIntoConstraints = false
//    iv.backgroundColor = .twitterblue
//    let tap = UITapGestureRecognizer(target: self, action: #selector(handleprofileImageTapped))
//    iv.addGestureRecognizer(tap)
//    iv.isUserInteractionEnabled = true
//    return iv
//}()

func iimageView(image: UIImage, height: CGFloat, width: CGFloat) -> UIImageView {
    let iv = UIImageView()
    iv.image = image
    iv.clipsToBounds = true
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.backgroundColor = .twitterblue
    
    return iv
}
