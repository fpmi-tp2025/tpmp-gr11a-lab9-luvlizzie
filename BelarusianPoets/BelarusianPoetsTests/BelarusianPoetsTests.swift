//
//  BelarusianPoetsTests.swift
//  BelarusianPoetsTests
//
//  Created by Елизавета on 12.05.2026.
//  Группа 12, вариант 11 (индивидуальное задание)
//

import XCTest
@testable import BelarusianPoets

final class BelarusianPoetsTests: XCTestCase {
    
    // MARK: - Test 1: Poet model initialization
    func testPoetInitialization() {
        let poet = Poet(
            id: 1,
            name: "Янка Купала",
            photoName: "kupala",
            biography: "Народны паэт Беларусі",
            works: ["Жалейка", "Гусляр"]
        )
        
        XCTAssertEqual(poet.id, 1)
        XCTAssertEqual(poet.name, "Янка Купала")
        XCTAssertEqual(poet.photoName, "kupala")
        XCTAssertEqual(poet.biography, "Народны паэт Беларусі")
        XCTAssertEqual(poet.works.count, 2)
    }
    
    // MARK: - Test 2: Poet photo loading
    func testPoetPhotoLoading() {
        let poet = Poet(
            id: 1,
            name: "Янка Купала",
            photoName: "kupala",
            biography: "",
            works: []
        )
        
        let photo = poet.photo
        XCTAssertNotNil(photo, "Photo should be loaded from assets")
    }
    
    // MARK: - Test 3: PoetsDataManager loads data from plist
    func testPoetsDataManagerLoadsPoets() {
        let poets = PoetsDataManager.shared.loadPoets()
        
        XCTAssertGreaterThan(poets.count, 0, "Poets array should not be empty")
        XCTAssertEqual(poets.first?.name, "Янка Купала")
    }
    
    // MARK: - Test 4: PoetsDataManager returns correct poet data
    func testPoetsDataManagerReturnsCorrectData() {
        let poets = PoetsDataManager.shared.loadPoets()
        
        let kupala = poets.first { $0.name == "Янка Купала" }
        
        XCTAssertNotNil(kupala, "Янка Купала не найден в plist")
        XCTAssertTrue(kupala?.works.contains("«Жалейка»") ?? false, "Список работ не содержит «Жалейка»")
    }
    
    // MARK: - Test 5: PoetsDataManager returns exactly 3 poets
    func testPoetsDataManagerReturnsThreePoets() {
        let poets = PoetsDataManager.shared.loadPoets()
        XCTAssertEqual(poets.count, 3)
    }
    
    // MARK: - Test 6: UserDefaultsManager saves and loads user
    func testUserDefaultsManagerSaveAndLoadUser() {
        let manager = UserDefaultsManager.shared
        manager.saveUser(login: "testuser", password: "testpass")
        
        let savedLogin = manager.getSavedLogin()
        let savedPassword = manager.getSavedPassword()
        
        XCTAssertEqual(savedLogin, "testuser")
        XCTAssertEqual(savedPassword, "testpass")
    }
    
    // MARK: - Test 7: UserDefaultsManager user exists check
    func testUserDefaultsManagerUserExists() {
        let manager = UserDefaultsManager.shared
        manager.saveUser(login: "existinguser", password: "pass")
        
        XCTAssertTrue(manager.isUserExists())
    }
    
    // MARK: - Test 8: UserDefaultsManager logout clears data
    func testUserDefaultsManagerLogout() {
        let manager = UserDefaultsManager.shared
        manager.saveUser(login: "todelete", password: "pass")
        manager.logout()
        
        XCTAssertFalse(manager.isUserExists())
        XCTAssertNil(manager.getSavedLogin())
    }
    
    // MARK: - Test 9: UserDefaultsManager login validation - success
    func testUserDefaultsManagerLoginSuccess() {
        let manager = UserDefaultsManager.shared
        manager.saveUser(login: "correctuser", password: "correctpass")
        
        let result = manager.login(login: "correctuser", password: "correctpass")
        XCTAssertTrue(result)
    }
    
    // MARK: - Test 10: UserDefaultsManager login validation - failure
    func testUserDefaultsManagerLoginFailure() {
        let manager = UserDefaultsManager.shared
        manager.saveUser(login: "correctuser", password: "correctpass")
        
        let result = manager.login(login: "wronguser", password: "wrongpass")
        XCTAssertFalse(result)
    }
    
    // MARK: - Test 11: Poet model encoding/decoding
    func testPoetCodable() throws {
        let originalPoet = Poet(
            id: 99,
            name: "Тестовый Поэт",
            photoName: "test_photo",
            biography: "Тестовая биография",
            works: ["Поэма 1", "Поэма 2", "Сонет"]
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(originalPoet)
        let decodedPoet = try decoder.decode(Poet.self, from: data)
        
        XCTAssertEqual(originalPoet.id, decodedPoet.id)
        XCTAssertEqual(originalPoet.name, decodedPoet.name)
        XCTAssertEqual(originalPoet.photoName, decodedPoet.photoName)
        XCTAssertEqual(originalPoet.biography, decodedPoet.biography)
        XCTAssertEqual(originalPoet.works, decodedPoet.works)
    }
    
    // MARK: - Test 12: All poets have unique IDs
    func testAllPoetsHaveUniqueIDs() {
        let poets = PoetsDataManager.shared.loadPoets()
        let ids = poets.map { $0.id }
        let uniqueIds = Set(ids)
        
        XCTAssertEqual(ids.count, uniqueIds.count, "All poets should have unique IDs")
    }
    
    // MARK: - Test 13: All poets have non-empty names
    func testAllPoetsHaveNonEmptyNames() {
        let poets = PoetsDataManager.shared.loadPoets()
        
        for poet in poets {
            XCTAssertFalse(poet.name.isEmpty, "Poet name should not be empty")
        }
    }
    
    // MARK: - Test 14: All poets have at least one work
    func testAllPoetsHaveAtLeastOneWork() {
        let poets = PoetsDataManager.shared.loadPoets()
        
        for poet in poets {
            XCTAssertGreaterThan(poet.works.count, 0, "Each poet should have at least one work")
        }
    }
    
    // MARK: - Test 15: UserDefaultsManager handles empty login correctly
    func testUserDefaultsManagerEmptyLogin() {
        let manager = UserDefaultsManager.shared
        manager.saveUser(login: "", password: "")
        
        let savedLogin = manager.getSavedLogin()
        let savedPassword = manager.getSavedPassword()
        
        XCTAssertEqual(savedLogin, "")
        XCTAssertEqual(savedPassword, "")
        XCTAssertTrue(manager.isUserExists())
    }
}
