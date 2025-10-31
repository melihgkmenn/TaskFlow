//
//  HomeView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showCreateTask = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Bugün Özeti").font(.title2).fontWeight(.bold)
                    HStack {
                        SummaryCard(title: "Bekleyen", count: 5, color: .orange)
                        SummaryCard(title: "Aktif", count: 2, color: .blue)
                        SummaryCard(title: "Tamamlanan", count: 8, color: .green)
                    }
                    
                    Text("Kısayollar").font(.title2).fontWeight(.bold)
                    VStack(spacing: 12) {
                        NavigationLink("Görevlerim", destination: TaskListView())
                        NavigationLink("Raporlarım", destination: ReportsView())
                        //NavigationLink("Konumum", destination: LocationView())
                        NavigationLink("Ayarlar", destination: SettingsView())
                    }
                    .font(.headline)
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Anasayfa")
                        .toolbar {
                            if authViewModel.isYonetici {
                                Button(action: { showCreateTask = true }) {
                                    Image(systemName: "plus")
                                    Text("Yeni Görev")
                                }
                            }
                        }
                        .sheet(isPresented: $showCreateTask) {
                            CreateTaskView()
                        }
        }
    }
}



// Anasayfa özet kartları
struct SummaryCard: View {
    var title: String
    var count: Int
    var color: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text("\(count)")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}
