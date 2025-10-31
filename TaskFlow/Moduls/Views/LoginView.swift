//
//  LoginView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var sifre = ""
    @State private var beniHatirla = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("TaskFlow")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("E-posta", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            SecureField("Şifre", text: $sifre)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            Toggle("Beni Hatırla", isOn: $beniHatirla)

            Button(action: {
                // Step 1: Firebase ile giriş yap
                authViewModel.login(email: email, sifre: sifre)
            }) {
                Text("Giriş Yap")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage) // "Geçersiz kimlik bilgisi"
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Spacer()
        }
        .padding()
    }
}
