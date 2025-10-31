//
//  CreateTaskView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI

struct CreateTaskView: View {
    @EnvironmentObject var taskViewModel: TaskListViewModel
    @Environment(\.dismiss) var dismiss

    @State private var görevAdi: String = ""
    @State private var konum: String = ""
    @State private var hedefSureSLA: Date = Date()
    @State private var atananKisi: String = ""
    @State private var aciklama: String = ""
    @State private var oncelik: String = "Orta"
    @State private var kategori: String = "Kurulum"
    
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Görev Bilgileri")) {
                    TextField("Görev Adı *", text: $görevAdi)
                    TextField("Konum (Pin/Arama) *", text: $konum)
                    DatePicker("Hedef Süre (SLA) *", selection: $hedefSureSLA)
                    TextField("Atanan Kişi/Ekip", text: $atananKisi)
                    TextField("Açıklama", text: $aciklama, axis: .vertical)
                }
                
                Section(header: Text("Ek Alanlar")) {
                    Picker("Öncelik", selection: $oncelik) {
                        Text("Düşük").tag("Düşük")
                        Text("Orta").tag("Orta")
                        Text("Yüksek").tag("Yüksek")
                    }
                    Picker("Kategori", selection: $kategori) {
                        Text("Kurulum").tag("Kurulum")
                        Text("Bakım").tag("Bakım")
                        Text("Denetim").tag("Denetim")
                    }
                }
                
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Görev Oluştur")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        saveTask()
                    }
                }
            }
        }
    }
    
    private func saveTask() {
        if görevAdi.isEmpty || konum.isEmpty {
            errorMessage = "Görev Adı ve Konum alanları zorunludur."
            return
        }
        
        let newTask = TaskModel(
            görevAdi: görevAdi,
            konum: konum,
            hedefSureSLA: hedefSureSLA,
            atananKisi: atananKisi,
            aciklama: aciklama,
            oncelik: oncelik,
            kategori: kategori,
            status: .yapilacak,
            olusturanUserID: "current_user_id_placeholder"
        )
        
        taskViewModel.createTask(task: newTask)
        dismiss()
    }
}
