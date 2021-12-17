//
//  Utilities.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 6/15/21.
//

import UIKit

class Utilities {
    func inputContainerView(image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv = UIImageView()
        iv.image = image
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iv)
        iv.heightAnchor.constraint(equalToConstant: 24) .isActive = true
        iv.widthAnchor.constraint(equalToConstant: 24) .isActive = true
        iv.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8) .isActive = true
        iv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8) .isActive = true
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftAnchor.constraint(equalTo: iv.leftAnchor, constant: 36) .isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8) .isActive = true
        
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(dividerView)
        dividerView.widthAnchor.constraint(equalTo: view.widthAnchor) .isActive = true
        dividerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1) .isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 0.75) .isActive = true
        
        
        
        return view
    }
    
    func textField(placeholder: String) -> UITextField {
        let textfield = UITextField()
        textfield.textColor = .white
        textfield.font = UIFont.systemFont(ofSize: 16)
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return textfield
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}
