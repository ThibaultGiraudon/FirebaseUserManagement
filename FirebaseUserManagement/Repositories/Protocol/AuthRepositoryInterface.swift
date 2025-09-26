//
//  AuthRepositoryInterface.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import Foundation

protocol AuthRepositoryInterface {
    func signIn(email: String, password: String) async throws -> String
    func signUp(email: String, password: String) async throws -> String
    func signOut() throws
    func identifyError(_ error: Error) -> String
}
