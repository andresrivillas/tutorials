//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Andres Rivillas on 9/04/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
