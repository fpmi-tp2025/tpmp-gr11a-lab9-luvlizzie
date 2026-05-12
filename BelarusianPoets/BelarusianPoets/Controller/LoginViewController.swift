//
//  LoginViewController.swift
//  BelarusianPoets
//
//  Created by Кудинова Елизавета on 10.05.2026.
//  Группа 12, вариант 11
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
        performSegue(withIdentifier: "showRegister", sender: nil)
    }
    
    // MARK: - Navigation
    private func navigateToPoetsList() {
        print("1. Функция вызвана")
        print("2. navigationController = \(navigationController)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("3. Storyboard загружен")
        
        if let poetsVC = storyboard.instantiateViewController(withIdentifier: "PoetsCollectionViewController") as? PoetsCollectionViewController {
            print("4. Контроллер создан: \(poetsVC)")
            navigationController?.pushViewController(poetsVC, animated: true)
            print("5. push выполнен")
        } else {
            print("4. ОШИБКА: Не удалось создать контроллер")
        }
    }
    
    // MARK: - Helpers
    private func showAlert(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("notice", comment: ""), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
