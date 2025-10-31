//
//  AuthService.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class AuthService {
    static let shared = AuthService()
    private init() {}
    
    var userSession: FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
    
    func login(email: String, sifre: String) -> AnyPublisher<FirebaseAuth.User, Error> {
        Future<FirebaseAuth.User, Error> { promise in
            Auth.auth().signIn(withEmail: email, password: sifre) { result, error in
                if let error = error {
                    promise(.failure(error))
                } else if let result = result {
                    promise(.success(result.user))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchUser(uid: String) -> AnyPublisher<AppUser, Error> {
        Firestore.firestore().collection("users").document(uid).getDocument_Combine()
            .tryMap { snapshot in
                let email = snapshot.data()?["email"] as? String ?? ""
                let roleString = snapshot.data()?["role"] as? String ?? "Teknisyen"
                let role = UserRole(rawValue: roleString) ?? .yonetici
                
                return AppUser(id: uid, email: email, role: role)
            }
            .eraseToAnyPublisher()
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

extension DocumentReference {
    func getDocument_Combine() -> Future<DocumentSnapshot, Error> {
        Future { promise in
            self.getDocument { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let snapshot = snapshot, snapshot.exists {
                    promise(.success(snapshot))
                }
            }
        }
    }
}
