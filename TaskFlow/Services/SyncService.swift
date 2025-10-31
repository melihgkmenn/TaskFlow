//
//  SyncService.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import SwiftData
import Combine

class SyncService {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func syncOnlineToOffline(tasks: [TaskModel]) {
        for task in tasks {
            let offlineTask = OfflineTask(
                id: task.id ?? UUID().uuidString,
                görevAdi: task.görevAdi,
                konum: task.konum,
                hedefSureSLA: task.hedefSureSLA,
                atananKisi: task.atananKisi,
                aciklama: task.aciklama,
                status: task.status.rawValue,
                needsSync: false
            )
            modelContext.insert(offlineTask)
        }
        try? modelContext.save()
    }
    
    func saveTaskLocally(task: TaskModel, needsSync: Bool) {
        let offlineTask = OfflineTask(
            id: task.id ?? UUID().uuidString,
            görevAdi: task.görevAdi,
            konum: task.konum,
            hedefSureSLA: task.hedefSureSLA,
            atananKisi: task.atananKisi,
            aciklama: task.aciklama,
            status: task.status.rawValue,
            needsSync: needsSync
        )
        modelContext.insert(offlineTask)
        try? modelContext.save()
    }
    
    func updateTaskLocally(task: TaskModel, needsSync: Bool) {
        // TODO:Mevcut offline task'ı bul ve güncelle
        
    }
    
    func startManualSync(onlineTasks: [TaskModel]) {
        print("Manuel Senkronizasyon Tetiklendi...")
        
    }
}
