//
//  Item.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 31.10.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
