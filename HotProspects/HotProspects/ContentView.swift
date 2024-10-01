//
//  ContentView.swift
//  HotProspects
//
//  Created by Andres Rivillas on 1/10/24.
//

import SamplePackage
import SwiftUI
import UserNotifications

struct ContentView: View {
    
    let possibleNumbers = 1...60
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    var body: some View {
        Text(results)
    }
}

#Preview {
    ContentView()
}
