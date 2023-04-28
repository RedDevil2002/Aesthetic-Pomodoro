//
//  Aesthetic_PomodoroApp.swift
//  Aesthetic Pomodoro
//
//  Created by Brian Seo on 2023-04-28.
//

import SwiftUI

@main
struct Aesthetic_PomodoroApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
