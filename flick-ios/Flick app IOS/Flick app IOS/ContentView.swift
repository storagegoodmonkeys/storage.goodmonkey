//
//  ContentView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootView()
            .environmentObject(AppState())
    }
}

#Preview {
    ContentView()
}
