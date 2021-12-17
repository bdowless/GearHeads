//
//  RegistrationController.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 6/16/21.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    //MARK: Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let uploadPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(plusPhotoButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)
        
        return view
        
    }()
    
    private lazy var passwordContainerView: UIView = {
        let iv = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        
        return iv
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let iv = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextField)
        
        return iv
    }()
    
    private lazy var usernameContainerView: UIView = {
        let iv = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
        
        return iv
    }()
    
    
    private let emailTextField: UITextField = {
        let iv = Utilities().textField(placeholder: "Email")
        return iv
    }()
    
    private let passwordTextField: UITextField = {
        let iv = Utilities().textField(placeholder: "Password")
        iv.isSecureTextEntry = true
        return iv
    }()
    
    private let fullnameTextField: UITextField = {
        let iv = Utilities().textField(placeholder: "Full Name")
        return iv
    }()
    
    private let usernameTextField: UITextField = {
        let iv = Utilities().textField(placeholder: "Username")
        iv.isSecureTextEntry = true
        return iv
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.twitterblue, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50) .isActive = true
        button.addTarget(self, action: #selector(handleregistrationButton), for: .touchUpInside)
        
        return button
    }()
    
 
    
    
    let signUpButton: UIButton = {
        let button = Utilities().atrributedButton(firstPart: "Already Have An Account ", secondPart: "Log In")
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        return button
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    //MARK: Selectors
    
    @objc func handleLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func plusPhotoButton() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleregistrationButton() {
        guard let profileImage = profileImage else {
            print("Please select profile image")
            return
        }
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        

        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            print("DEBUG: Sign Up Succesfull")
        }

    }

    //MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterblue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        
        view.addSubview(signUpButton)
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10) .isActive = true
        
        view.addSubview(uploadPhotoButton)
        uploadPhotoButton.heightAnchor.constraint(equalToConstant: 150) .isActive = true
        uploadPhotoButton.widthAnchor.constraint(equalToConstant: 150) .isActive = true
        uploadPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
        uploadPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40) .isActive = true
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, registrationButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
        stack.topAnchor.constraint(equalTo: uploadPhotoButton.bottomAnchor, constant: 10) .isActive = true
        stack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32) .isActive = true
        }
    }


extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        uploadPhotoButton.layer.cornerRadius = 150 / 2
        uploadPhotoButton.layer.masksToBounds = true
        uploadPhotoButton.imageView?.contentMode = .scaleAspectFill
        uploadPhotoButton.imageView?.clipsToBounds = true
        uploadPhotoButton.layer.borderColor = UIColor.white.cgColor
        uploadPhotoButton.layer.borderWidth = 2
        self.uploadPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
        }
    }

