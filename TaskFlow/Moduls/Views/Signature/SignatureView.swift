//
//  SignatureView.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import SwiftUI
import PencilKit

struct SignatureView: View {
    @Environment(\.dismiss) var dismiss
    var task: TaskModel
    @State private var canvasView = PKCanvasView()
    
    var body: some View {
        VStack {
            Text("Görevi Onaylamak İçin İmzalayın")
                .font(.headline)
                .padding()
            
            CanvasViewRepresentable(canvasView: $canvasView)
                .frame(height: 300)
                .border(Color.gray, width: 1)
                .padding()
            
            HStack {
                Button("Temizle") {
                    canvasView.drawing = PKDrawing()
                }
                
                Button("Kaydet ve Tamamla") {
                    let signatureImage = canvasView.drawing.image(from: canvasView.bounds, scale: 1.0)
                    let signatureData = signatureImage.pngData()
                    
                    // TODO: ViewModel üzerinden bu imzayı ve durumu Firebase'e kaydet
                    // var updatedTask = task
                    // updatedTask.signatureData = signatureData
                    // updatedTask.status = .tamamlandi
                    // taskViewModel.updateTask(task: updatedTask)
                    
                    print("İmza kaydedildi, görev tamamlandı.")
                    dismiss()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

struct CanvasViewRepresentable: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}
