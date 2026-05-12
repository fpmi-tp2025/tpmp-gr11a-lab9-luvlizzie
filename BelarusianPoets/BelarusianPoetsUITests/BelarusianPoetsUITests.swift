//
//  BelarusianPoetsUITests.swift
//  BelarusianPoetsUITests
//
//  Created by Кудинова Елизавета on 12.05.2026.
//  Группа 12, вариант 11 (индивидуальное задание)
//

import XCTest

final class BelarusianPoetsUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["--reset-defaults"]
        app.launch()
    }
    
    // MARK: - Helper: Clear and type text
    private func typeText(_ element: XCUIElement, text: String) {
        element.tap()
        element.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: 30))
        element.typeText(text)
    }
    
    // MARK: - Helper: Register a user
    private func registerUser(login: String, password: String) {
        app.buttons["registerButton"].tap()
        
        typeText(app.textFields["loginTextField"], text: login)
        typeText(app.secureTextFields["passwordTextField"], text: password)
        typeText(app.secureTextFields["confirmTextField"], text: password)
        
        app.buttons["registerButton"].tap()
        
        let alert = app.alerts.firstMatch
        if alert.waitForExistence(timeout: 3) {
            alert.buttons.firstMatch.tap()
        }
        
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        if backButton.waitForExistence(timeout: 3) {
            backButton.tap()
        }
    }
    
    // MARK: - Helper: Login
    private func login(login: String, password: String) {
        typeText(app.textFields["loginTextField"], text: login)
        typeText(app.secureTextFields["passwordTextField"], text: password)
        app.buttons["loginButton"].tap()
    }
    
    // MARK: - Test 1: Login screen elements exist
    func testLoginScreenElementsExist() {
        XCTAssertTrue(app.textFields["loginTextField"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.secureTextFields["passwordTextField"].exists)
        XCTAssertTrue(app.buttons["loginButton"].exists)
        XCTAssertTrue(app.buttons["registerButton"].exists)
    }
    
    // MARK: - Test 2: Navigate to registration screen
    func testNavigateToRegistrationScreen() {
        app.buttons["registerButton"].tap()
        XCTAssertTrue(app.secureTextFields["confirmTextField"].waitForExistence(timeout: 3))
    }
    
    // MARK: - Test 3: Register new user successfully
    func testRegisterNewUserSuccessfully() {
        app.buttons["registerButton"].tap()
        
        typeText(app.textFields["loginTextField"], text: "newuser")
        typeText(app.secureTextFields["passwordTextField"], text: "newpass")
        typeText(app.secureTextFields["confirmTextField"], text: "newpass")
        
        app.buttons["registerButton"].tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
    }
    
    // MARK: - Test 4: Registration with mismatched passwords shows error
    func testRegistrationWithMismatchedPasswordsShowsError() {
        app.buttons["registerButton"].tap()
        
        typeText(app.textFields["loginTextField"], text: "testuser")
        typeText(app.secureTextFields["passwordTextField"], text: "pass123")
        typeText(app.secureTextFields["confirmTextField"], text: "different")
        
        app.buttons["registerButton"].tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
    }
    
    // MARK: - Test 5: Registration with empty fields shows error
    func testRegistrationWithEmptyFieldsShowsError() {
        app.buttons["registerButton"].tap()
        app.buttons["registerButton"].tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
    }
    
    // MARK: - Test 6: Empty fields login shows alert
    func testEmptyFieldsLoginShowsAlert() {
        app.buttons["loginButton"].tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
    }
    
    // MARK: - Test 7: Login with invalid credentials shows alert
    func testLoginWithInvalidCredentialsShowsAlert() {
        typeText(app.textFields["loginTextField"], text: "wrong")
        typeText(app.secureTextFields["passwordTextField"], text: "wrong")
        
        app.buttons["loginButton"].tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
    }
    
    // MARK: - Test 8: Create user and login successfully
    func testCreateUserAndLoginSuccessfully() {
        let user = "user8"
        let pass = "pass8"
        
        registerUser(login: user, password: pass)
        login(login: user, password: pass)
        
        let collectionView = app.collectionViews.firstMatch
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
    }
    
    // MARK: - Test 9: Poets collection view has cells after login
    func testPoetsCollectionViewHasCells() {
        let user = "user9"
        let pass = "pass9"
        
        registerUser(login: user, password: pass)
        login(login: user, password: pass)
        
        let collectionView = app.collectionViews.firstMatch
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
        XCTAssertGreaterThan(collectionView.cells.count, 0)
    }
    
    // MARK: - Test 10: Logout returns to login screen
    func testLogoutReturnsToLoginScreen() {
        let user = "user10"
        let pass = "pass10"
        
        registerUser(login: user, password: pass)
        login(login: user, password: pass)
        
        // Ищем кнопку по названию "Выйти"
        let logoutBtn = app.buttons["Выйти"]
        XCTAssertTrue(logoutBtn.waitForExistence(timeout: 5))
        logoutBtn.tap()
        
        let loginField = app.textFields["loginTextField"]
        XCTAssertTrue(loginField.waitForExistence(timeout: 5))
    }
    
    // MARK: - Test 11: Tap on first poet opens detail screen
    func testTapOnFirstPoetOpensDetailScreen() {
        let user = "user11"
        let pass = "pass11"
        
        registerUser(login: user, password: pass)
        login(login: user, password: pass)
        
        let firstCell = app.collectionViews.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()
        
        let nameLabel = app.staticTexts["nameLabel"]
        XCTAssertTrue(nameLabel.waitForExistence(timeout: 5))
    }

    // MARK: - Test 12: Detail screen shows poet's works
    func testDetailScreenShowsPoetWorks() {
        let user = "user12"
        let pass = "pass12"
        
        registerUser(login: user, password: pass)
        login(login: user, password: pass)
        
        let firstCell = app.collectionViews.cells.firstMatch
        firstCell.tap()
        
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.waitForExistence(timeout: 5))
        XCTAssertGreaterThan(tableView.cells.count, 0)
    }

    // MARK: - Test 13: Back button on detail screen returns to list
    func testBackButtonReturnsToList() {
        let user = "user13"
        let pass = "pass13"
        
        registerUser(login: user, password: pass)
        login(login: user, password: pass)
        
        let firstCell = app.collectionViews.cells.firstMatch
        firstCell.tap()
        
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()
        
        let collectionView = app.collectionViews.firstMatch
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
    }

    // MARK: - Test 14: Logout button exists after login
    func testLogoutButtonExists() {
        let user = "user14"
        let pass = "pass14"
        
        registerUser(login: user, password: pass)
        login(login: user, password: pass)
        
        let logoutBtn = app.buttons["Выйти"]
        XCTAssertTrue(logoutBtn.waitForExistence(timeout: 5))
    }

    // MARK: - Test 15: Multiple poets in collection view
    func testMultiplePoetsInCollectionView() {
        let user = "user15"
        let pass = "pass15"
        
        registerUser(login: user, password: pass)
        login(login: user, password: pass)
        
        let cells = app.collectionViews.cells
        XCTAssertTrue(cells.count >= 3, "Should have at least 3 poets")
    }
}
