//
//  OfflineTask.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import SwiftData

@Model
final class OfflineTask {
    
    @Attribute(.unique) var id: String = ""
    var signatureData: Data?
    
    private var _mediaURLsData: Data = Data()
    private var _checklistData: Data = Data()
    
    var mediaURLs: [String] {
        get { (try? JSONDecoder().decode([String].self, from: _mediaURLsData)) ?? [] }
        set { _mediaURLsData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }
    
    var checklist: [ChecklistItem] {
        get { (try? JSONDecoder().decode([ChecklistItem].self, from: _checklistData)) ?? [] }
        set { _checklistData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }
    
    init() { }
    
    init(id: String, görevAdi: String, konum: String, hedefSureSLA: Date,
         atananKisi: String, aciklama: String, status: String, needsSync: Bool,
         signatureData: Data? = nil, mediaURLs: [String] = [], checklist: [ChecklistItem] = [])
    {
        self.id = id
        self.signatureData = signatureData
        self.mediaURLs = mediaURLs
        self.checklist = checklist
    }
}
