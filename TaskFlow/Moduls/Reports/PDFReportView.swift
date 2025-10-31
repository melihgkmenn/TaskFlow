//
//  PDFReportView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let data: Data

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(data: data)
    }
}

struct PDFReportView: View {
    var task: TaskModel
    @State private var pdfData: Data?
    private let pdfService = PDFService()
    
    var body: some View {
        VStack {
            if let pdfData = pdfData {
                PDFKitView(data: pdfData)
            } else {
                ProgressView("PDF Raporu Oluşturuluyor...")
                    .onAppear {
                        self.pdfData = pdfService.createPDF(task: task)
                    }
            }
        }
        .navigationTitle("Rapor Önizleme")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if let data = pdfData {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ShareLink(
                        item: data,
                        preview: SharePreview(
                            "\(task.görevAdi) Raporu.pdf",
                            icon: Image(systemName: "doc.text.fill")
                        )
                    ) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
    }
}
