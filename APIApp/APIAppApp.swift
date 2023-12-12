//
//  APIAppApp.swift
//  APIApp
//
//  Created by Владислав Лесовой on 12.12.2023.
//

import SwiftUI
import SwiftData

@main
struct APIAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Photo.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainWindow()
        }
        .modelContainer(sharedModelContainer)
    }
}
