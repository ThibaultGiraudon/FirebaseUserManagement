//
//  RegisterView.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var session: SessionStore
    @State private var email: String = ""
    @State private var fullname: String = ""
    @State private var password: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    private var shouldDisabled: Bool {
        email.isEmpty || password.isEmpty || fullname.isEmpty
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            TextField("Fullname", text: $fullname)
                .textFieldStyle(.roundedBorder)
                .textContentType(.name)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button {
                Task {
                    await session.signUp(fullname: fullname, email: email, password: password)
                    if session.error == nil {
                        dismiss()
                    }
                }
            } label: {
                Text("Create an account")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(shouldDisabled ? 0.4 : 1))
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .overlay {
                if session.isLoading {
                    ProgressView()
                }
            }
            .padding(.top, 50)
            .disabled(shouldDisabled)
        }
        .padding()
        .overlay(alignment: .bottom) {
            if let error = session.error {
                Text(error)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    RegisterView(session: .init())
}
