//
//  LoginViewController.swift
//  Messenger
//
//  Created by Gabriel de Castro Chaves on 17/06/23.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Log In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Register",
            style: .done,
            target: self,
            action: #selector(didTapRegiter)
        )
        setupSubView()
        setupActionButtons()
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = view.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width-60,
                                 height: 52)
        passwordField.frame = CGRect(x: 30,
                                  y: emailField.bottom + 10,
                                  width: scrollView.width-60,
                                 height: 52)
        loginButton.frame = CGRect(x: 30,
                                  y: passwordField.bottom + 10,
                                  width: scrollView.width-60,
                                 height: 52)

    }
    
    //MARK: UI Components
    private let scrollView: UIScrollView = {
        let component = UIScrollView()
        component.clipsToBounds = true
        return component
    }()
    
    private let imageView: UIImageView = {
        let component = UIImageView()
        component.image = UIImage(named: "logo")
        component.contentMode = .scaleAspectFit
        return component
    }()
    
    private let emailField: UITextField = {
        let component = UITextField()
        component.autocapitalizationType = .none
        component.autocorrectionType = .no
        component.returnKeyType = .continue
        component.layer.cornerRadius = 12
        component.layer.borderWidth = 1
        component.layer.borderColor = UIColor.lightGray.cgColor
        component.placeholder = "Email address..."
        component.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        component.leftViewMode = .always
        component.backgroundColor = .white
        return component
    }()
    
    private let passwordField: UITextField = {
        let component = UITextField()
        component.autocapitalizationType = .none
        component.autocorrectionType = .no
        component.returnKeyType = .done
        component.layer.cornerRadius = 12
        component.layer.borderWidth = 1
        component.layer.borderColor = UIColor.lightGray.cgColor
        component.placeholder = "Password..."
        component.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        component.leftViewMode = .always
        component.backgroundColor = .white
        component.isSecureTextEntry = true
        return component
    }()
    
    private let loginButton: UIButton = {
        let component = UIButton()
        component.setTitle("Log In", for: .normal)
        component.backgroundColor = .link
        component.setTitleColor(UIColor.white, for: .normal)
        component.layer.cornerRadius = 12
        component.layer.masksToBounds = true
        component.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return component
    }()
    
    //MARK: Functions
    private func setupSubView() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to log in",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss",
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(action)
    }
    
    private func setupActionButtons() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    //MARK: Actions
    @objc private func loginButtonTapped() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6 else {
            alertUserLoginError()
            return
        }
        //Firebase Log In
    }
    
    @objc private func didTapRegiter() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
}
