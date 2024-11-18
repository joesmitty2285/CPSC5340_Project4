//
//  AuthView.swift
//  Notes
//
//  Created by Joseph Smith on 11/17/24.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn = Auth.auth().currentUser != nil
    @State private var errorDescription = ""
    
    var body: some View {
            if isSignedIn {
                ContentView() 
            } else {
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Sign In") {
                        signIn()
                    }
                    .padding()

                    Button("Sign Up") {
                        signUp()
                    }
                    .padding()

                    Text(errorDescription)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                .padding()
            }
        }
        
        private func signIn() {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    errorDescription = error.localizedDescription
                } else {
                    isSignedIn = true
                }
            }
        }

        private func signUp() {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    errorDescription = error.localizedDescription
                } else {
                    isSignedIn = true
                }
            }
        }
    }

#Preview {
    AuthView()
}
