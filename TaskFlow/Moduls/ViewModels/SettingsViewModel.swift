//
//  SettingsViewModel.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import SwiftUI
import Combine

enum ThemeOption: String, CaseIterable, Identifiable {
    case system = "Sistem"
    case light = "Açık"
    case dark = "Koyu"
    
    var id: String { self.rawValue }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var selectedTheme: ThemeOption = .system
}
