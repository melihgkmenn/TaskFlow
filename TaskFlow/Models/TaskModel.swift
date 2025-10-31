//
//  TaskModel.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import FirebaseFirestore

enum TaskStatus: String, Codable, CaseIterable, Identifiable, Hashable {
    case planlandi = "Planlandı"
    case yapilacak = "Yapılacak"
    case calismada = "Çalışmada"
    case kontrol = "Kontrol"
    case tamamlandi = "Tamamlandı"
    var id: String { self.rawValue }
}

struct TaskModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var görevAdi: String
    var konum: String
    var hedefSureSLA: Date
    var atananKisi: String
    var aciklama: String
    var oncelik: String
    var kategori: String
    var status: TaskStatus
    var olusturanUserID: String
    
    var checklist: [ChecklistItem] = []
    var mediaURLs: [String] = []
    var signatureData: Data?

    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(görevAdi)
        hasher.combine(konum)
        hasher.combine(hedefSureSLA)
        hasher.combine(atananKisi)
        hasher.combine(aciklama)
        hasher.combine(oncelik)
        hasher.combine(kategori)
        hasher.combine(status)
        hasher.combine(olusturanUserID)
        hasher.combine(checklist)
        hasher.combine(mediaURLs)
        
    }
    
    var viewID: String {
            return id ?? UUID().uuidString
    }
    
}
