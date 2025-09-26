//
//  FakeData.swift
//  FirebaseUserManagementTests
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import Foundation
@testable import FirebaseUserManagement

struct FakeData {
    static var user: User = .init(
        uid: "12345",
        email: "test@test.com",
        fullname: "Test User"
    )
    
    static var error = URLError(.badURL)
}
