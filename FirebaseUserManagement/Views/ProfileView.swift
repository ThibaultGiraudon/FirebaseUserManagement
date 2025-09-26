//
//  ProfileView.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @ObservedObject var session: SessionStore
    @State private var fullname: String = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var showPhotosPicker: Bool = false
    @State private var isImageLoading: Bool = false
    var body: some View {
        VStack(alignment: .center) {
            Group {
                if let urlString = session.session?.imageURL, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(Color.gray)
                        .background {
                            Circle()
                                .fill(.white)
                        }
                        .padding(.top, 100)
                }
            }
            .overlay(alignment: .bottom) {
                if isImageLoading {
                    ProgressView()
                        .tint(.gray)
                        .controlSize(.large)
                        .frame(width: 200, height: 200)
                        .background {
                            Circle()
                                .fill(.white.opacity(0.5))
                        }
                }
            }
            .onTapGesture {
                showPhotosPicker = true
            }
            .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItem, matching: .images)
            .onChange(of: selectedItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            selectedItem = nil
                            isImageLoading = true
                            await session.uploadImage(uiImage)
                            isImageLoading = false
                        }
                    }
                }
            }
            
            TextField("Fullname", text: $fullname)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text(session.session?.email ?? "Loading...")
                .font(.headline)
            
            Spacer()
            
            Button {
                Task {
                    await session.updateUser(fullname: fullname)
                }
            } label: {
                Text("Save")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(fullname.isEmpty ? 0.4 : 1))
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .overlay {
                if session.isLoading {
                    ProgressView()
                }
            }
            .padding(.top, 50)
            .disabled(fullname.isEmpty)
            
            Button {
                session.signOut()
            } label: {
                Text("Log Out")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            
        }
        .padding()
        .onAppear {
            self.fullname = session.session?.fullname ?? ""
        }
    }
}

#Preview {
    ProfileView(session: {
        let session = SessionStore()
        session.session = User(
            uid: "123",
            email: "test@test.app",
            fullname: "Test User"
        )
        return session
    }())
}
