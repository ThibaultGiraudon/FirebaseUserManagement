//
//  FirestoreRepository.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import Foundation
import FirebaseFirestore

class FirestoreRepository: FirestoreRepositoryInterface {
    let db = Firestore.firestore()
    
    func fetchUser(with uid: String) async throws -> User? {
        let document = try await db.collection("users").document(uid).getDocument()
        return User(document.data())
    }
    
    func addUser(_ user: User) async throws {
        try await db.collection("users").document(user.uid).setData(user.data())
    }
    
    func updateUser(_ user: User) async throws {
        try await db.collection("users").document(user.uid).setData(user.data())
    }
}
