# tpmp-gr11a-lab9-luvlizzie

## Description

This repository contains the **individual assignment** for Laboratory Work No. 9 – "Design of a Mobile Application with Continuous Integration and Automated Testing".

The project is based on **Task 2.1 from Laboratory Work No. 8** — "Belarusian Poets" app. This app allows users to register, log in, browse a list of Belarusian poets (loaded from a `.plist` file), view poet details (biography and works), and log out.

**Implemented in this lab:**
- **15 Unit tests** (XCTest) – testing model, data manager, UserDefaults manager, and codable conformance.
- **15 UI tests** (XCTest) – testing login, registration, navigation, collection view interactions, detail screen, and logout.
- **Test Plan** documented.

---

## Installation

### 1. Clone the repository

```bash
git clone git@github.com:fpmi-tp2025/tpmp-gr11a-lab9-luvlizzie.git
cd tpmp-gr11a-lab9-luvlizzie
```

### 2. Open the project in Xcode

```bash
open BelarusianPoets/BelarusianPoets.xcodeproj
```

### 3. Select a simulator and run

- Choose an iOS simulator (e.g., iPhone 17 Pro)
- Press `Cmd + R` to build and run the app
- Press `Cmd + U` to run all tests

---

## Usage

### App Features

1. **Registration**: Create a new account (login + password + confirmation)
2. **Login**: Enter existing credentials to access the poets list
3. **Poets List**: Browse poets in a UICollectionView (2 columns)
4. **Poet Detail**: Tap on a poet to see full biography and list of works
5. **Logout**: Tap the "Выйти" button to return to the login screen

### Test Execution

#### Run all tests (Xcode)
- **Product → Test** (`Cmd + U`)

#### Run Unit tests only
```bash
xcodebuild test \
  -project BelarusianPoets.xcodeproj \
  -scheme BelarusianPoets \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=latest' \
  -only-testing:BelarusianPoetsTests
```

#### Run UI tests only
```bash
xcodebuild test \
  -project BelarusianPoets.xcodeproj \
  -scheme BelarusianPoets \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=latest' \
  -only-testing:BelarusianPoetsUITests
```

#### Run with clean state
The app launches with `--reset-defaults` argument to clear `UserDefaults` before each test run.

---

## Authors

- **Kudinova Elizaveta** – group 12, variant 11
- Contact: kudinovaea2006@yandex.by

---

## Links and Additional Notes

- [GitHub Repository](https://github.com/fpmi-tp2025/tpmp-gr11a-lab9-luvlizzie)
- [Lab Report](https://disk.yandex.ru/i/k6fPScXCmdBYFg)
- [Tests Completion Screen Recording](https://disk.yandex.ru/i/A_-kbtl8mdkQGA)

### Additional Notes

- All tests are implemented using **XCTest** framework (compatible with UIKit projects).
- UI tests use `waitForExistence(timeout:)` to handle asynchronous UI loading.
- Each UI test creates its own unique test user to avoid state conflicts.
- The app supports 3 languages: Russian, English, Belarusian (using `.lproj` files).
- Accessibility identifiers are added for all UI elements used in tests.

---

## Test Plan

### 1. Unit Tests (15 tests)

Unit tests verify the correctness of individual components (models, data managers, utilities) in isolation.

| # | Test Name | Description | Expected Result |
|---|-----------|-------------|------------------|
| 1 | `testPoetInitialization` | Verify Poet model initialization with id, name, photoName, biography, works | All properties match input values |
| 2 | `testPoetPhotoLoading` | Verify photo loading from assets by photoName | UIImage is not nil |
| 3 | `testPoetsDataManagerLoadsPoets` | Verify PoetsDataManager loads data from poets.plist | Poets array is not empty, first poet is "Янка Купала" |
| 4 | `testPoetsDataManagerReturnsCorrectData` | Verify poet data integrity from plist | Янка Купала found, works contain "Жалейка" |
| 5 | `testPoetsDataManagerReturnsThreePoets` | Verify exactly 3 poets in plist | poets.count == 3 |
| 6 | `testUserDefaultsManagerSaveAndLoadUser` | Verify saving and loading user credentials | Saved login/password match retrieved values |
| 7 | `testUserDefaultsManagerUserExists` | Verify user existence check after saving | isUserExists() returns true |
| 8 | `testUserDefaultsManagerLogout` | Verify logout clears user data | isUserExists() returns false, login is nil |
| 9 | `testUserDefaultsManagerLoginSuccess` | Verify login with correct credentials | login() returns true |
| 10 | `testUserDefaultsManagerLoginFailure` | Verify login with incorrect credentials | login() returns false |
| 11 | `testPoetCodable` | Verify JSON encoding/decoding of Poet model | Decoded poet equals original |
| 12 | `testAllPoetsHaveUniqueIDs` | Verify all poets have unique IDs | Set size equals array size |
| 13 | `testAllPoetsHaveNonEmptyNames` | Verify no poet has empty name | All names are not empty |
| 14 | `testAllPoetsHaveAtLeastOneWork` | Verify each poet has at least one work | works.count > 0 for all poets |
| 15 | `testUserDefaultsManagerEmptyLogin` | Verify handling of empty credentials | Empty login/password are saved correctly |

### 2. UI Tests (15 tests)

UI tests verify user interface behavior and user interaction flows.

| # | Test Name | Description | Expected Result |
|---|-----------|-------------|------------------|
| 1 | `testLoginScreenElementsExist` | Verify all login screen elements are present | loginTextField, passwordTextField, loginButton, registerButton exist |
| 2 | `testNavigateToRegistrationScreen` | Verify navigation to registration screen | confirmTextField appears on registration screen |
| 3 | `testRegisterNewUserSuccessfully` | Verify successful user registration | Alert appears with success message |
| 4 | `testRegistrationWithMismatchedPasswordsShowsError` | Verify error on password mismatch | Alert appears with error message |
| 5 | `testRegistrationWithEmptyFieldsShowsError` | Verify error on empty registration fields | Alert appears with error message |
| 6 | `testEmptyFieldsLoginShowsAlert` | Verify error on empty login fields | Alert appears |
| 7 | `testLoginWithInvalidCredentialsShowsAlert` | Verify error on invalid login credentials | Alert appears |
| 8 | `testCreateUserAndLoginSuccessfully` | Verify full registration → login flow | Poets collection view appears |
| 9 | `testPoetsCollectionViewHasCells` | Verify collection view is populated | Collection view has at least one cell |
| 10 | `testLogoutReturnsToLoginScreen` | Verify logout button returns to login screen | Login screen appears after logout |
| 11 | `testTapOnFirstPoetOpensDetailScreen` | Verify tapping poet opens detail screen | nameLabel appears on detail screen |
| 12 | `testDetailScreenShowsPoetWorks` | Verify detail screen displays works table | Table view has at least one cell |
| 13 | `testBackButtonReturnsToList` | Verify back button navigation works | Collection view reappears |
| 14 | `testLogoutButtonExists` | Verify logout button is present after login | Logout button exists |
| 15 | `testMultiplePoetsInCollectionView` | Verify at least 3 poets are displayed | Collection view cell count ≥ 3 |

### 3. Test Data

| Test Data | Value | Purpose |
|-----------|-------|---------|
| Test User 1 | login: "testuser", password: "testpass" | Basic login/registration tests |
| Test User 2 | login: "wrong", password: "wrong" | Invalid credentials tests |
| Test Users 3-15 | Dynamic unique users per test | Prevent state interference between tests |

### 4. Test Execution Results

```
** TEST SUCCEEDED **
Executed 30 tests (15 Unit + 15 UI) with 0 failures
```

| Result | Count |
|--------|-------|
| ✅ Passed | 30 |
| ❌ Failed | 0 |
| ⏭ Skipped | 0 |

### 5. Test Plan Version

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 12.05.2026 | Initial test plan with 15 unit tests and 15 UI tests |

---
