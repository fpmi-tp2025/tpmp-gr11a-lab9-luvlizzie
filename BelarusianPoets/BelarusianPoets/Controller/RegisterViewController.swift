//
//  RegisterViewController.swift
//  BelarusianPoets
//
//  Created by Кудинова Елизавета on 10.05.2026.
//  Группа 12, вариант 11
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = NSLocalizedString("register_title", comment: "")
        view.backgroundColor = .systemBackground
        
        loginTextField.placeholder = NSLocalizedString("login_placeholder", comment: "")
        loginTextField.borderStyle = .roundedRect
        loginTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = NSLocalizedString("password_placeholder", comment: "")
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        
        confirmTextField.placeholder = NSLocalizedString("confirm_password", comment: "")
        confirmTextField.borderStyle = .roundedRect
        confirmTextField.isSecureTextEntry = true
        
        registerButton.setTitle(NSLocalizedString("register_button", comment: ""), for: .normal)
        registerButton.backgroundColor = .systemGreen
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 8
    }
    
    // MARK: - Actions
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirm = confirmTextField.text, !confirm.isEmpty else {
            showAlert(message: NSLocalizedString("fill_fields", comment: ""))
            return
        }
        
        guard password == confirm else {
            showAlert(message: NSLocalizedString("passwords_mismatch", comment: ""))
            return
        }
        
        defaults.set(login, forKey: "saved_login")
        defaults.set(password, forKey: "saved_password")
        defaults.set(true, forKey: "isLoggedIn")
        
        showAlert(message: NSLocalizedString("registration_success", comment: "")) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Helpers
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: NSLocalizedString("notice", comment: ""), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}
