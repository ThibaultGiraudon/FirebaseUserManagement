//
//  AuthRepositoryTests.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import XCTest
@testable import FirebaseUserManagement
import FirebaseAuth

@MainActor
final class AuthRepositoryTests: XCTestCase {
    
    func testSignUpAndSignInAndSignOutShouldSucceed() async {
        let email = "user@test.app"
        let password = "12345678"

        let repositoriy = AuthRepository()
        
        do {
            let uid = try await repositoriy.signUp(email: email, password: password)
            XCTAssertFalse(uid.isEmpty)
        } catch {
            XCTFail("Registration failed: \(error)")
        }
        
        do {
            try repositoriy.signOut()
            XCTAssertNil(repositoriy.auth.currentUser)
        } catch {
            XCTFail("Signing out failed: \(error)")
        }
        
        do {
            let uid = try await repositoriy.signIn(email: email, password: password)
            XCTAssertFalse(uid.isEmpty)
        } catch {
            XCTFail("Signg in failed: \(error)")
        }
    }
    
    func testRegisterShouldFailWithBadEmailFormat() async {
        let email = "testuser"
        let password = "testpassword"
        
        let repositoriy = AuthRepository()
        
        do {
            _ = try await repositoriy.signUp(email: email, password: password)
            XCTFail("Registration should failed")
        } catch {
            let nsError = error as NSError
            let authCode = AuthErrorCode(rawValue: nsError.code)
            XCTAssertEqual(authCode, AuthErrorCode.invalidEmail)
        }
    }

    func testSignInShouldFailWithUserNotFound() async {
        let email = "test2@example.com"
        let password = "testpassword"
        
        let repositoriy = AuthRepository()
        
        do {
            _ = try await repositoriy.signIn(email: email, password: password)
            XCTFail("Registration should failed")
        } catch {
            let nsError = error as NSError
            let authCode = AuthErrorCode(rawValue: nsError.code)
            XCTAssertEqual(authCode, AuthErrorCode.userNotFound)
        }
    }

}
