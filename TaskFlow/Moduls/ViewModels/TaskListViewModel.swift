//
//  TaskListViewModel.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import Combine
import SwiftData

@MainActor
class TaskListViewModel: ObservableObject {
    @Published var tasks = [TaskModel]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var taskService = TaskService.shared
    private var syncService: SyncService
    private var cancellables = Set<AnyCancellable>()

        init(modelContext: ModelContext) {
            self.syncService = SyncService(modelContext: modelContext)
            fetchAllTasks()
        }

    func fetchAllTasks() {
            isLoading = true
            taskService.fetchTasks()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    self.isLoading = false
                    if case .failure(let error) = completion {
                        self.errorMessage = error.localizedDescription
                        print("Firebase'den çekilemedi, offline veriler yükleniyor...")
                        self.fetchOfflineTasks()
                    }
                } receiveValue: { tasks in
                    self.tasks = tasks
                    self.syncService.syncOnlineToOffline(tasks: tasks)
                }
                .store(in: &cancellables)
        }
    
    func fetchOfflineTasks() {
        // TODO: OfflineTask'ları TaskModel'e map et
        // self.tasks = syncService.fetchLocalTasks().map { ... }
    }
    
    func createTask(task: TaskModel) {
        taskService.createTask(task: task)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    print("Task online oluşturulamadı, offline için sıraya alınıyor...")
                    self.syncService.saveTaskLocally(task: task, needsSync: true)
                }
            } receiveValue: {
                print("Task başarıyla oluşturuldu.")
            }
            .store(in: &cancellables)
    }
    
    func updateTaskStatus(task: TaskModel, newStatus: TaskStatus) {
        guard let taskID = task.id else { return }
        var updatedTask = task
        updatedTask.status = newStatus
        taskService.updateTask(task: updatedTask)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    self.syncService.updateTaskLocally(task: updatedTask, needsSync: true)
                }
            } receiveValue: {
                print("Task durumu güncellendi.")
                self.fetchAllTasks()
            }
            .store(in: &cancellables)
    }
}
