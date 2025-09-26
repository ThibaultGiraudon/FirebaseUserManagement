//
//  StorageRepositoryInterface.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import SwiftUI

protocol StorageRepositoryInterface {
    func uploadImage(_ uiImage: UIImage, to path: String) async throws -> String
    func deleteImage(with url: String) async throws
}
