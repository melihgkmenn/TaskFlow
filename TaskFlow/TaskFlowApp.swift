//
//  TaskFlowApp.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI
import FirebaseCore
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct TaskFlowApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    let modelContainer: ModelContainer

    @StateObject private var authViewModel: AuthViewModel
    @StateObject private var taskViewModel: TaskListViewModel
    @StateObject private var settingsViewModel: SettingsViewModel

    init() {
            let localModelContainer: ModelContainer
            do {
                let schema = Schema([OfflineTask.self])
                let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
                localModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
            
            self.modelContainer = localModelContainer

            _authViewModel = StateObject(wrappedValue: AuthViewModel())
            _taskViewModel = StateObject(wrappedValue: TaskListViewModel(modelContext: localModelContainer.mainContext))
            _settingsViewModel = StateObject(wrappedValue: SettingsViewModel())
            
        }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(authViewModel)
        .environmentObject(taskViewModel)
        .environmentObject(settingsViewModel)
        .modelContainer(modelContainer)
    }
}
