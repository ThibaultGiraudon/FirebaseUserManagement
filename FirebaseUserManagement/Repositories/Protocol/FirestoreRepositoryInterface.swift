//
//  FirestoreRepositoryInterface.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import Foundation

protocol FirestoreRepositoryInterface {
    func fetchUser(with uid: String) async throws -> User?
    func addUser(_ user: User) async throws
    func updateUser(_ user: User) async throws
}
