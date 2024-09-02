//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Andres Rivillas on 22/04/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
