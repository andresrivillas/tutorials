//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Andres Rivillas on 1/10/24.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
