//
//  FirestoreRepositoryFake.swift
//  FirebaseUserManagementTests
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import Foundation
@testable import FirebaseUserManagement

class FirestoreRepositoryFake: FirestoreRepositoryInterface {
    var user: User?
    var error: Error?
    
    func fetchUser(with uid: String) async throws -> User? {
        if let error {
            throw error
        }
        return user
    }
    
    func addUser(_ user: FirebaseUserManagement.User) async throws {
        if let error {
            throw error
        }
    }
    
    func updateUser(_ user: FirebaseUserManagement.User) async throws {
        if let error {
            throw error
        }
    }
}
