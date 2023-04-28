//
//  ContentView.swift
//  Aesthetic Pomodoro
//
//  Created by Brian Seo on 2023-04-28.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        SessionView(title: "👨🏻‍💻 iOS Development")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
