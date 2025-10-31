//
//  AuthViewModel.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import Combine
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: AppUser?
    @Published var errorMessage: String?
    
    private var authService = AuthService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        checkAuthenticationStatus()
    }
    
    func checkAuthenticationStatus() {
        self.userSession = authService.userSession
        if let user = self.userSession {
            fetchUser(uid: user.uid)
        }
    }

    // Step 1: Firebase Authentication
    func login(email: String, sifre: String) {
        authService.login(email: email, sifre: sifre)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = "Giriş hatası: \(error.localizedDescription)"
                }
            } receiveValue: { user in
                self.userSession = user
                self.fetchUser(uid: user.uid)
            }
            .store(in: &cancellables)
    }

    func fetchUser(uid: String) {
        authService.fetchUser(uid: uid)
            .sink { _ in }
            receiveValue: { user in
                self.currentUser = user
            }
            .store(in: &cancellables)
    }

    func logout() {
        authService.logout()
        self.userSession = nil
        self.currentUser = nil
    }
    
    var isYonetici: Bool {
        return true
        //return currentUser?.role == .yonetici
    }
}
