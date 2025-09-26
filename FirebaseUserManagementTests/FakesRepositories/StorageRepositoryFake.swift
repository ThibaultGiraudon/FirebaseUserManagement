//
//  StorageRepositoryFake.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//


import SwiftUI
@testable import FirebaseUserManagement

class StorageRepositoryFake: StorageRepositoryInterface {
    var imageURL: String = ""
    var error: Error?
    func uploadImage(_ uiImage: UIImage, to path: String) async throws -> String {
        if let error {
            throw error
        }
        return imageURL
    }
    
    func deleteImage(with url: String) async throws {
        if let error {
            throw error
        }
    }
    
}
