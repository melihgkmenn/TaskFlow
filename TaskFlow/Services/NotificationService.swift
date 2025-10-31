//
//  NotificationService.swift
//  TaskFlow
//
//  Created by Melih Gökmen on 26.10.2025.
//

import Foundation
import UserNotifications

class NotificationService {
    func scheduleSLANotification(task: TaskModel) {
        let content = UNMutableNotificationContent()
        content.title = "SLA Hatırlatması"
        content.body = "'\(task.görevAdi)' görevinin hedef süresi yaklaşıyor!"
        content.sound = .default

        let triggerDate = Calendar.current.date(byAdding: .hour, value: -1, to: task.hedefSureSLA)!
        let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        let request = UNNotificationRequest(identifier: task.id ?? UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Bildirim kurulamadı: \(error.localizedDescription)")
            }
        }
    }
}
