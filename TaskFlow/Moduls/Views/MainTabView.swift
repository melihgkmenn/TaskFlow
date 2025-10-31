//
//  MainTabView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Anasayfa", systemImage: "house.fill")
                }
            TaskListView()
                .tabItem {
                    Label("Görevler", systemImage: "list.bullet.clipboard.fill")
                }
            ReportsView()
                .tabItem {
                    Label("Raporlar", systemImage: "doc.text.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Ayarlar", systemImage: "gearshape.fill")
                }
        }
        .preferredColorScheme(settingsViewModel.selectedTheme.colorScheme)
    }
}
