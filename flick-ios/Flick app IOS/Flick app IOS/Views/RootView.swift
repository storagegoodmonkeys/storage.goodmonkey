//
//  RootView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.isFirstTime {
                OnboardingView()
            } else if !appState.isAuthenticated {
                AuthView()
            } else {
                MainTabView()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AppState())
}


