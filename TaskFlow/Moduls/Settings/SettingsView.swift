//
//  SettingsView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var taskViewModel: TaskListViewModel
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Form {
            Section(header: Text("Görünüm")) {
                Picker("Tema", selection: $settingsViewModel.selectedTheme) {
                    ForEach(ThemeOption.allCases) { theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }
            }
            
            Section(header: Text("Senkronizasyon (Step 2)")) {
                Toggle("Yalnızca Wi-Fi'da Senkronize Et", isOn: .constant(true))
                Button("Manuel Senkronizasyon Başlat") {
                    let syncService = SyncService(modelContext: modelContext)
                    syncService.startManualSync(onlineTasks: taskViewModel.tasks)
                }
            }
            
            Section {
                Button("Çıkış Yap", role: .destructive) {
                    authViewModel.logout()
                }
            }
        }
        .navigationTitle("Ayarlar")
    }
}
