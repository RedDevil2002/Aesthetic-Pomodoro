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
       
        MenuBarExtra("Aesthetic", systemImage: "timer.square") {
            // SESSION
            SessionView(title: "👨🏻‍💻 iOS Development")
            
            // QUIT
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
            
        }
        .menuBarExtraStyle(.window)
    }
}
