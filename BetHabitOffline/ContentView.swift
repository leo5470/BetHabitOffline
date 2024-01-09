//
//  ContentView.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/8.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        Text("Hello World")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
