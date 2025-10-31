//
//  TaskListView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskViewModel: TaskListViewModel

    var body: some View {
        NavigationStack {
            List(taskViewModel.tasks) { task in
                NavigationLink(destination: TaskDetailView(task: task)) {
                    TaskRowView(task: task)
                }
            }
            .navigationTitle("Görevler")
            .onAppear {
                taskViewModel.fetchAllTasks()
            }
        }
    }
}

struct TaskRowView: View {
    var task: TaskModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.görevAdi).font(.headline)
            Text(task.atananKisi).font(.subheadline)
            Text(task.status.rawValue).font(.caption).foregroundColor(.secondary)
            
            if task.hedefSureSLA < Date() && task.status != .tamamlandi {
                Text("SLA SÜRESİ GEÇTİ")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
        }
    }
}
