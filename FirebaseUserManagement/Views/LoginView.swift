//
//  LoginView.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var session: SessionStore
    @State private var email: String = ""
    @State private var password: String = ""
    
    private var shouldDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button {
                Task {
                    await session.signIn(email: email, password: password)
                }
            } label: {
                Text("Sign In")
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
            
            NavigationLink {
                RegisterView(session: session)
            } label: {
                Text("Create an account")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.blue, lineWidth: 1)
                    }
                    .foregroundColor(.blue)
            }
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
    LoginView(session: .init())
}
