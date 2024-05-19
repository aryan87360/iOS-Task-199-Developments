//
//  SignupView.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var mobile: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Mobile", text: $mobile)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
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

            Button("Signup") {
                signup()
            }
            .padding()
        }
        .padding()
    }

    private func signup() {
        guard isValidNameOrDomain(name) else {
            errorMessage = "Name must be between 4 and 25 characters."
            return
        }

        guard isValidIndianMobileNumber(mobile) else {
            errorMessage = "Invalid Indian mobile number."
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Invalid email address."
            return
        }

        guard isValidPassword(password, userName: name) else {
            errorMessage = "Invalid password."
            return
        }

        if let encryptedPassword = EncryptionHelper.encrypt(password) {
            let newUser = User(name: name, mobile: mobile, email: email, encryptedPassword: encryptedPassword)
            UserDefaults.standard.savedUser = newUser
            presentationMode.wrappedValue.dismiss()
        }
    }
}

    func isValidNameOrDomain(_ nameOrDomain: String) -> Bool {
        return nameOrDomain.count >= 4 && nameOrDomain.count <= 25
    }

    func isValidIndianMobileNumber(_ mobile: String) -> Bool {
        let mobileRegex = "^[6-9]\\d{9}$"
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        return mobilePredicate.evaluate(with: mobile)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]{4,25}@[A-Za-z0-9.-]{4,25}\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String, userName: String) -> Bool {
        guard password.count >= 8 && password.count <= 15 else { return false }
        guard !password.lowercased().contains(userName.lowercased()) else { return false }
        guard password.first?.isLowercase ?? false else { return false }

        let uppercaseCount = password.reduce(0) { $0 + ($1.isUppercase ? 1 : 0) }
        guard uppercaseCount >= 2 else { return false }

        let digitsCount = password.reduce(0) { $0 + ($1.isNumber ? 1 : 0) }
        guard digitsCount >= 2 else { return false }

        let specialCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").inverted
        guard password.rangeOfCharacter(from: specialCharacters) != nil else { return false }

        return true
}
