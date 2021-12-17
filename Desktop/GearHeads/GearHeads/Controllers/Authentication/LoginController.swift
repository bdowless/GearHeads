//
//  LoginController.swift
//  TwitterTutorial2021
//
//  Created by Brandon Dowless on 6/15/21.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: Properties
   
    private let logoImage: UIImageView = {
        let twitterImage = UIImageView()
        twitterImage.image = #imageLiteral(resourceName: "TwitterLogo")
        twitterImage.contentMode = .scaleAspectFill
        twitterImage.clipsToBounds = true
        twitterImage.translatesAutoresizingMaskIntoConstraints = false
        return twitterImage
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)
        
        return view
        
    }()
    
    private lazy var passwordContainerView: UIView = {
        let iv = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        
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
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.twitterblue, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50) .isActive = true
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        
        return button
    }()
    
//    let logInButton: UIButton = {
//        let iv = UIButton(type: .system)
//        iv.setTitle("Log In", for: .normal)
//        iv.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        iv.setTitleColor(.twitterblue, for: .normal)
//        iv.backgroundColor = .white
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.layer.cornerRadius = 5
//        iv.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
//        return iv
//    }()
    
    
    let dontHaveAnAccountButton: UIButton = {
        let button = Utilities().atrributedButton(firstPart: "Dont Have An Account ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTwitterImage()
        stackView()
        configureDontHaveAccount()
        
        
    }
    //MARK: Selectors
    
    @objc func handleLoginButton() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("DEBUG: Error logging in")
                return
            }
                        
            guard let uid = result?.user.uid else { return }
            
            UserService.shared.fetchUser(uid: uid) { user in
                guard let root = UIApplication.shared.keyWindow?.rootViewController as? MainTabController else { return }
                root.user = user
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleSignUp() {
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    //MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterblue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    func configureTwitterImage() {
        view.addSubview(logoImage)
        logoImage.heightAnchor.constraint(equalToConstant: 150) .isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 150) .isActive = true
        logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40) .isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
    }
    
    func stackView() {
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20) .isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
        stack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32) .isActive = true
    }
    
    func configureDontHaveAccount() {
        view.addSubview(dontHaveAnAccountButton)
        dontHaveAnAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
        dontHaveAnAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10) .isActive = true
    }
}
