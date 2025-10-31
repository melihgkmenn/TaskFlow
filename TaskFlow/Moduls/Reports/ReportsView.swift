//
//  ReportsView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI

struct ReportsView: View {
    @State private var reports = [
        "TASKFLOW_20251005_1030_ABC123.pdf",
        "TASKFLOW_20250930_1542_DEF456.pdf",
        "TASKFLOW_20250921_0911_GHI789.pdf"
    ]

    var body: some View {
        NavigationStack {
            List(reports, id: \.self) { reportName in
                VStack(alignment: .leading) {
                    Text(reportName)
                        .font(.headline)
                    Text("Görev Detayı... Rapor Tarihi...")
                        .font(.caption)
                }
            }
            .navigationTitle("Raporlarım")
            .toolbar {
                
                
            }
        }
    }
}
