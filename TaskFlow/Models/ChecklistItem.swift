//
//  ChecklistItem.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation

struct ChecklistItem: Codable, Identifiable, Hashable {
    var id = UUID()
    var text: String
    var isCompleted: Bool
}
