//
//  LoginView.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var isUserLoggedIn: Bool
    @State private var mobileOrEmail: String = ""
    @State private var password: String = ""
    @State private var showingSignup = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            TextField("Mobile or Email", text: $mobileOrEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button("Login") {
                login()
            }
            .padding()
            
            NavigationLink(destination: SignupView()) {
                Text("Don't have an account? Sign Up")
            }
            .padding()
        }
        .padding()
    }
    
    private func login() {
        guard let savedUser = UserDefaults.standard.savedUser else {
            errorMessage = "No user found. Please sign up."
            return
        }
        
        if let decryptedPassword = EncryptionHelper.decrypt(savedUser.encryptedPassword),
           (savedUser.email == mobileOrEmail || savedUser.mobile == mobileOrEmail),
           decryptedPassword == password {
            isUserLoggedIn = true
        } else {
            errorMessage = "Invalid credentials. Please try again."
        }
    }
}
