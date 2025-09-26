//
//  ContentView.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var session: SessionStore = .init()
    
    var body: some View {
        VStack {
            switch session.authenticationState {
            case .signedIn:
                ProfileView(session: session)
            case .signedOut:
                LoginView(session: session)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
