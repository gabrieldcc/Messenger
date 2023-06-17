//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Gabriel de Castro Chaves on 17/06/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
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
        imageView.layer.cornerRadius = imageView.width/2.0
        firstNameField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        lastNameField.frame = CGRect(x: 30,
                                  y: firstNameField.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)
        registerButton.frame = CGRect(x: 30,
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
        component.image = UIImage(systemName: "person")
        component.tintColor = .gray
        component.contentMode = .scaleAspectFit
        component.layer.masksToBounds = true
        component.layer.borderColor = UIColor.lightGray.cgColor
        component.layer.borderWidth = 1
        return component
    }()
    
    private let firstNameField: UITextField = {
        let component = UITextField()
        component.autocapitalizationType = .none
        component.autocorrectionType = .no
        component.returnKeyType = .continue
        component.layer.cornerRadius = 12
        component.layer.borderWidth = 1
        component.layer.borderColor = UIColor.lightGray.cgColor
        component.placeholder = "First name..."
        component.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        component.leftViewMode = .always
        component.backgroundColor = .white
        return component
    }()
    
    private let lastNameField: UITextField = {
        let component = UITextField()
        component.autocapitalizationType = .none
        component.autocorrectionType = .no
        component.returnKeyType = .continue
        component.layer.cornerRadius = 12
        component.layer.borderWidth = 1
        component.layer.borderColor = UIColor.lightGray.cgColor
        component.placeholder = "Last name..."
        component.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        component.leftViewMode = .always
        component.backgroundColor = .white
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
    
    private let registerButton: UIButton = {
        let component = UIButton()
        component.setTitle("Register", for: .normal)
        component.backgroundColor = .systemGreen
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
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to create a new account",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss",
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func setupActionButtons() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapChangeProfilePic)
        )
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
    }
    
    //MARK: Actions
    @objc private func registerButtonTapped() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
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
    
    @objc private func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(
            title: "Profile Picture",
            message: "How wold you like to select a picture?",
            preferredStyle: .actionSheet
        )
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        })
        let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self]_ in
            self?.presentPhotoPicker()
        })
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(choosePhotoAction)
        present(actionSheet, animated: true
        )
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage]  as? UIImage else {
            return
        }
        self.imageView.image = selectedImage
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
