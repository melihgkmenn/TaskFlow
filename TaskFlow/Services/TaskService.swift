//
//  TaskService.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import FirebaseFirestore
import Combine

class TaskService {
    static let shared = TaskService()
    private let db = Firestore.firestore().collection("tasks")
    
    func createTask(task: TaskModel) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            do {
                try self.db.document().setData(from: task)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchTasks() -> AnyPublisher<[TaskModel], Error> {
        db.getDocuments_Combine()
            .tryMap { snapshot in
                try snapshot.documents.compactMap {
                    try $0.data(as: TaskModel.self)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func updateTask(task: TaskModel) -> AnyPublisher<Void, Error> {
        guard let taskID = task.id else {
            return Fail(error: NSError(domain: "TaskService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Task ID missing"])).eraseToAnyPublisher()
        }
        
        return Future<Void, Error> { promise in
            do {
                try self.db.document(taskID).setData(from: task)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension CollectionReference {
    func getDocuments_Combine() -> Future<QuerySnapshot, Error> {
        Future { promise in
            self.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let snapshot = snapshot {
                    promise(.success(snapshot))
                }
            }
        }
    }
}
