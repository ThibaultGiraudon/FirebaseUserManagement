//
//  AuthRepositoryFake.swift
//  FirebaseUserManagementTests
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import Foundation
@testable import FirebaseUserManagement

class AuthRepositoryFake: AuthRepositoryInterface {
    var uid: String = ""
    var errorString: String = ""
    var error: Error?
    
    func signIn(email: String, password: String) async throws -> String {
        if let error {
            throw error
        }
        return uid
    }
    
    func signUp(email: String, password: String) async throws -> String {
        if let error {
            throw error
        }
        return uid
    }
    
    func signOut() throws {
        if let error {
            throw error
        }
    }
    
    func identifyError(_ error: any Error) -> String {
        return errorString
    }
}
