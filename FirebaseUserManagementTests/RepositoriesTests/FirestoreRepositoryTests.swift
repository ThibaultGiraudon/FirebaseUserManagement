//
//  FirestoreRepositoryTests.swift
//  FirebaseUserManagementTests
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import XCTest
import Firebase
@testable import FirebaseUserManagement

@MainActor
final class FirestoreRepositoryTests: XCTestCase {

    func testAddAndFetchAndUpdateUser() async {
        let repository = FirestoreRepository()
        
        var user = FakeData.user
        
        do {
            try await repository.addUser(user)
        } catch {
            XCTFail("Adding user failed: \(error)")
        }
        
        do {
            let fetchedUser = try await repository.fetchUser(with: user.uid)
            XCTAssertEqual(fetchedUser, user)
        } catch {
            XCTFail("Fetching user faield: \(error)")
        }
        
        user.fullname = "Charles Leclerc"
        
        do {
            try await repository.updateUser(user)
            let fetchedUser = try await repository.fetchUser(with: user.uid)
            
            XCTAssertEqual(fetchedUser?.fullname, "Charles Leclerc")
        } catch {
            XCTFail("Updating user failed: \(error)")
        }
    }

}
