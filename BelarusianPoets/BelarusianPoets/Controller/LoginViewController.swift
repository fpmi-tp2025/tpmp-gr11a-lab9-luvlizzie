//
//  LoginViewController.swift
//  BelarusianPoets
//
//  Created by Кудинова Елизавета on 10.05.2026.
//  Группа 12, вариант 11 (индивидуальное задание)
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ProcessInfo.processInfo.arguments.contains("--reset-defaults") {
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
        }
        
        setupUI()
        checkAutoLogin()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = NSLocalizedString("login_title", comment: "")
        view.backgroundColor = .systemBackground
        
        loginTextField.placeholder = NSLocalizedString("login_placeholder", comment: "")
        loginTextField.borderStyle = .roundedRect
        loginTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = NSLocalizedString("password_placeholder", comment: "")
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        
        loginButton.setTitle(NSLocalizedString("login_button", comment: ""), for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        
        registerButton.setTitle(NSLocalizedString("register_button", comment: ""), for: .normal)
        registerButton.setTitleColor(.systemBlue, for: .normal)
        
        view.accessibilityIdentifier = "loginScreen" 
        loginTextField.accessibilityIdentifier = "loginTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        loginButton.accessibilityIdentifier = "loginButton"
        registerButton.accessibilityIdentifier = "registerButton"
    }
    
    private func checkAutoLogin() {
        if defaults.bool(forKey: "isLoggedIn") {
            navigateToPoetsList()
        }
    }
    
    // MARK: - Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: NSLocalizedString("fill_fields", comment: ""))
            return
        }
        
        let savedLogin = defaults.string(forKey: "saved_login") ?? ""
        let savedPassword = defaults.string(forKey: "saved_password") ?? ""
        
        if login == savedLogin && password == savedPassword {
            defaults.set(true, forKey: "isLoggedIn")
            navigateToPoetsList()
        } else {
            showAlert(message: NSLocalizedString("invalid_credentials", comment: ""))
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            navigationController?.pushViewController(registerVC, animated: true)
        }
    }

    private func navigateToPoetsList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let poetsVC = storyboard.instantiateViewController(withIdentifier: "PoetsCollectionViewController") as? PoetsCollectionViewController {
            navigationController?.pushViewController(poetsVC, animated: true)
        }
    }
    
    // MARK: - Helpers
    private func showAlert(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("notice", comment: ""), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
