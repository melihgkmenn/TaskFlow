//
//  Item.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 31.10.2025.
//

import Foundation

enum UserRole: String, Codable {
    case yonetici = "Yonetici"
    case teknisyen = "Teknisyen"
    case unknown = "Bilinmiyor"
}

struct AppUser: Identifiable {
    var id: String // Firebase UID
    var email: String
    var role: UserRole
}
