//
//  SwiftDataContextManager.swift
//  POC_PhotoKit
//
//  Created by Theo Sementa on 13/05/2025.
//

import Foundation
import CoreData
import SwiftData
import Models

@MainActor
public final class SwiftDataContextManager: ObservableObject {
    public static let shared = SwiftDataContextManager()

    public nonisolated static let remoteChangeNotification = Notification.Name("SwiftDataContextManager.remoteChange")

    public let container: ModelContainer
    var context: ModelContext

    private init() {
        do {
            let config = ModelConfiguration(cloudKitDatabase: .private("iCloud.com.sementa.renta"))
            container = try ModelContainer(for: ItemEntity.self, TagEntity.self, UserSettingsEntity.self, configurations: config)
            context = container.mainContext
        } catch {
            fatalError("Échec de l'initialisation du ModelContainer: \(error.localizedDescription)")
        }

        observeRemoteChanges()
    }

    private func observeRemoteChanges() {
        NotificationCenter.default.addObserver(
            forName: .NSPersistentStoreRemoteChange,
            object: nil,
            queue: .main
        ) { _ in
            NotificationCenter.default.post(name: Self.remoteChangeNotification, object: nil)
        }
    }
}
