//
//  UserDefaultsManager.swift
//  BelarusianPoets
//
//  Created by Елизавета on 12.05.2026.
//  Группа 12, вариант 11 (индивидуальное задание)
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    private let loginKey = "saved_login"
    private let passwordKey = "saved_password"
    private let loggedInKey = "isLoggedIn"
    
    func saveUser(login: String, password: String) {
        UserDefaults.standard.set(login, forKey: loginKey)
        UserDefaults.standard.set(password, forKey: passwordKey)
    }
    
    func getSavedLogin() -> String? {
        return UserDefaults.standard.string(forKey: loginKey)
    }
    
    func getSavedPassword() -> String? {
        return UserDefaults.standard.string(forKey: passwordKey)
    }
    
    func isUserExists() -> Bool {
        return getSavedLogin() != nil
    }
    
    func login(login: String, password: String) -> Bool {
        return login == getSavedLogin() && password == getSavedPassword()
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: loginKey)
        UserDefaults.standard.removeObject(forKey: passwordKey)
        UserDefaults.standard.set(false, forKey: loggedInKey)
    }
}
