//
//  PDFService.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import PDFKit

class PDFService {
    func createPDF(task: TaskModel) -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "TaskFlow App",
            kCGPDFContextAuthor: "taskflow.com"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let pageSize = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4
        let renderer = UIGraphicsPDFRenderer(bounds: pageSize, format: format)

        let data = renderer.pdfData { (context) in
            context.beginPage()
            
            let title = "Görev Raporu: \(task.görevAdi)"
            title.draw(at: CGPoint(x: 30, y: 30), withAttributes: [.font: UIFont.boldSystemFont(ofSize: 24)])
            
            let details = """
            Durum: \(task.status.rawValue)
            Atanan: \(task.atananKisi)
            SLA: \(task.hedefSureSLA.formatted())
            Açıklama: \(task.aciklama)
            """
            details.draw(at: CGPoint(x: 30, y: 70), withAttributes: [.font: UIFont.systemFont(ofSize: 12)])
            
            if let signatureData = task.signatureData, let signatureImage = UIImage(data: signatureData) {
                context.cgContext.saveGState()
                context.cgContext.translateBy(x: 30, y: 200)
                signatureImage.draw(in: CGRect(x: 0, y: 0, width: 150, height: 75))
                context.cgContext.restoreGState()
                
                "Elektronik olarak imzalanmıştır.".draw(at: CGPoint(x: 30, y: 280), withAttributes: [.font: UIFont.italicSystemFont(ofSize: 10)])
            }
        }
        return data
    }
}
