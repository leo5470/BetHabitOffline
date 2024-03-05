//
//  BetHabitOfflineApp.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/8.
//

import SwiftUI
import SwiftData

@main
struct BetHabitOfflineApp: App {
    @Environment(\.modelContext) var model
    @AppStorage("lastLogin") var lastLogin = Date.now
    
    init() {
        
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Habit.self
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
