//
//  TaskDetailView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject var taskViewModel: TaskListViewModel
    var task: TaskModel
    @State private var showSignaturePad = false

    var body: some View {
        Form {
            Section(header: Text("Görev Detayı")) {
                Text(task.görevAdi)
                Text("Durum: \(task.status.rawValue)")
                Text("SLA: \(task.hedefSureSLA.formatted())")
                Text("Atanan: \(task.atananKisi)")
                Text("Açıklama: \(task.aciklama)")
            }
            
            Section(header: Text("Aşamalar")) {
                TaskStatusSection(title: "Yapılacak", details: "Atanmış görev başlıyor")
                TaskStatusSection(title: "Çalışmada", details: "Fotoğraf, Video, Notlar")
                TaskStatusSection(title: "Kontrol", details: "Checklist")
                TaskStatusSection(title: "Tamamlandı", details: "")
            }
            
            Section {
                if let nextStatus = getNextStatus(current: task.status) {
                    Button("Durumu Güncelle: \(nextStatus.rawValue)") {
                        taskViewModel.updateTaskStatus(task: task, newStatus: nextStatus)
                    }
                }
            }
            
            if task.status == .kontrol {
                Button("Tamamla ve İmzala") {
                    showSignaturePad = true
                }
                .foregroundColor(.blue)
            }
            
            if task.status == .tamamlandi {
                NavigationLink(destination: PDFReportView(task: task)) {
                    Text("PDF Raporu Oluştur")
                }
            }
        }
        .navigationTitle("Görev Detayı")
        .sheet(isPresented: $showSignaturePad) {
            //E-imza ekranı
            SignatureView(task: task)
        }
    }
    
    func getNextStatus(current: TaskStatus) -> TaskStatus? {
        switch current {
        case .planlandi: return .yapilacak
        case .yapilacak: return .calismada
        case .calismada: return .kontrol
        case .kontrol: return .tamamlandi
        case .tamamlandi: return nil
        }
    }
}

struct TaskStatusSection: View {
    var title: String
    var details: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline)
            Text(details).font(.subheadline).foregroundColor(.secondary)
        }
    }
}
