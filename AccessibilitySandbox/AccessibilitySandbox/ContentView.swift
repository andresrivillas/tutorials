//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Andres Rivillas on 28/08/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Button("Jon F Kennedy"){
            print("Button tapped")
        }.accessibilityInputLabels(["John Fitgerald Kennedy", "Kennedy", "JFK"])
    }
}

#Preview {
    ContentView()
}
